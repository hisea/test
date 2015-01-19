class Api::MessagesController < Api::BaseController

  private

  def message_params
    params.require(:message).permit(:subject, :body, :user_id)
  end

  def query_params
    # this assumes that a dream belongs to a user and has an :user_id
    # allowing us to filter by this
    params.permit(:user_id, :subject, :body)
  end
end
