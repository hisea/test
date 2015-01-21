class User < ActiveRecord::Base
  has_many :messages
  belongs_to :country
  has_many :subscriptions
end
