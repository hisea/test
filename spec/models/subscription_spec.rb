require 'rails_helper'

RSpec.describe Subscription, :type => :model do
  let(:country) { FactoryGirl.create(:country)}
  let(:user) { FactoryGirl.create(:user, country: country) }
  let(:sub_price) { FactoryGirl.create(:subscription_price, country: country) }

  context "validation" do
    it { should validate_presence_of(:user) }
  end

  context "relationships" do
    it { should belong_to :currency_country }
  end

  describe "subscribe!" do

    before(:each) do
      SubscriptionPrice.stub(:for_country).and_return(sub_price)
    end
    it "should allow a new user to subscribe" do
      sub = Subscription.new(user: user)
      expect(sub.subscribe!).to be_truthy
      expect(sub.currency_country).to eq(country)
      expect(sub.amount_paid).to eq(sub_price.price)
    end
    it "should now allow a user to subscribe if the user already has an active subscription" do
      Subscription.create(user: user)
      sub = Subscription.new(user: user)
      expect(sub.subscribe!).to be_nil
      expect(sub.errors.messages[:user]).to include("Only one active subscription allowed!")
    end
  end

  describe "cancel" do
    it "should cancel the subscription in 24 hours" do
      sub = Subscription.new(user: user)
      Timecop.freeze(Time.now) do
        sub.cancel!
        expect(sub.cancelled_at).to eq(Time.now + 1.day)
      end
    end
  end
end
