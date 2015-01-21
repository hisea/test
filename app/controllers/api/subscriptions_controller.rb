class Api::SubscriptionsController < ApplicationController

  protect_from_forgery with: :null_session

  before_action :load_user, except: [ :cancel, :reactivate ]
  before_action :load_subscription, only: [ :cancel, :reactivate ]

  def index
    @active = @user.subscriptions.active
    @cancelled = @user.subscriptions.cancelled
  end

  def show
  end

  def create
    @subscription = Subscription.new(:user_id => @user.id)
    render_subscription :subscribe!
  end

  def cancel
    render_subscription :cancel!
  end

  def reactivate
    render_subscription :reactivate!
  end

  protected

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_subscription
    @subscription = Subscription.find(params[:id])
  end
  private

  def render_subscription(action)
    if @subscription.send(action)
      head :ok
    else
      render :json => @subscription.errors, :status => :unprocessable_entity
    end
  end

  def subscription_params
    params.require(:subscription).permit(:cancelled_at, :user_id)
  end

  def query_params
    params.permit(:user_id, :cancelled_at)
  end

end
