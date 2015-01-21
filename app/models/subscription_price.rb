class SubscriptionPrice < ActiveRecord::Base
  belongs_to :country

  scope :for_country, ->(country) { find_by(country_id: country.id)}
end
