class Subscription < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where("cancelled_at >= ? OR cancelled_at is NULL", Time.now) }
  scope :cancelled, -> { where("cancelled_at < ?", Time.now) }

  belongs_to :currency_country, class_name: "Country"
  validates :user, presence: true

  def cancel!
    update_attributes(cancelled_at: 1.day.from_now)
  end

  def reactivate!
    update_attributes(cancelled_at: nil)
  end

  def subscribe!
    if user.subscriptions.active.size == 0
      return self.process_payment
    else
      self.errors.add(:user, "Only one active subscription allowed!")
      return nil
    end
  end

  def process_payment
    update_attributes(amount_paid: SubscriptionPrice.for_country(user.country).price,
                      currency_country: user.country,
                      activated_at: Time.now)
  end

end
