class MessagesController < ApplicationController
  def list

    @messages = Message.where(:user_id => params[:user_id])
    @user = User.find(params[:user_id])
  end

end
