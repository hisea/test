module SubscriptionSpec
  include Capybara::Angular::DSL

  feature 'subscription page' do
    before(:each) do
      @country = FactoryGirl.create(:country)
      @user = FactoryGirl.create(:user, country: @country)
      @price = FactoryGirl.create(:subscription_price, country: @country)
    end
    scenario 'can visit the subscription page from user page', js: true do
      visit '/users'
      expect(page).to have_link 'Manage Subscription'
    end

    context "subscriptions" do
      before(:each) do
      end

      scenario 'subscription page has purchase button for unsubscribed user', js: true do
        visit "/users/#{@user.id}/subscriptions"
        expect(page).to have_button "Subscribe for #{@country.currency} $#{@price.price}"
      end

      scenario 'no subscribe button if user already has a active subscription', js: true do
        sub = FactoryGirl.create(:subscription, user: @user, cancelled_at: nil)
        visit "/users/#{@user.id}/subscriptions"
        expect(page).not_to have_button "Subscribe for #{@country.currency} $#{@price.price}"
      end

      scenario 'shows active subscription', js: true do
        visit "/users/#{@user.id}/subscriptions"
        click_on "Subscribe for #{@country.currency} $#{@price.price}"
        within("#active") do
          expect(page).to have_content "for $#{@price.price} #{@country.currency}"
        end
      end

      scenario 'shows cancelled subscription', js: true do
        sub = FactoryGirl.create(:subscription, user: @user, cancelled_at: "2014-1-1")
        visit "/users/#{@user.id}/subscriptions"
        within("#cancelled") do
          expect(page).to have_content "Cancelled at: 2014-01-01T00:00:00.000Z"
        end
      end

      scenario 'user can cancel active subscription', js: true do
        visit "/users/#{@user.id}/subscriptions"
        click_on "Subscribe for #{@country.currency} $#{@price.price}"
        expect(page).to have_button "Cancel"
        click_on "Cancel"
        within("#active") do
          expect(page).to have_content("for $1.5 CAD - To Be Cancelled at:")
        end
      end

      scenario 'after user cancelled the subscription, user can reactivate', js: true do
        visit "/users/#{@user.id}/subscriptions"
        click_on "Subscribe for #{@country.currency} $#{@price.price}"
        click_on "Cancel"
        expect(page).to have_button "Reactivate"
        click_on "Reactivate"
        within("#active") do
          expect(page).to have_content "for $#{@price.price} #{@country.currency}"
        end
      end

      scenario 'subscription cancelled more than 24 ago cannot be reactivated', js: true do
        sub = FactoryGirl.create(:subscription, user: @user, cancelled_at: "2014-1-1")
        visit "/users/#{@user.id}/subscriptions"
        expect(page).not_to have_button "Reactivate"
      end

      scenario 'usr can subscribe if all his/her subscription is cancelled more than 24 hours ago', js: true do
        sub = FactoryGirl.create(:subscription, user: @user, cancelled_at: "2014-1-1")
        visit "/users/#{@user.id}/subscriptions"
        expect(page).to have_button "Subscribe for #{@country.currency} $#{@price.price}"
      end
    end
  end
end
