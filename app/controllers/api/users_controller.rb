class Api::UsersController < Api::BaseController
  protect_from_forgery with: :null_session
  private

  def user_params
    params.require(:user).permit(:name)
  end

  def query_params
    params.permit(:name)
  end

end
