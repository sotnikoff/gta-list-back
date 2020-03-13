class Auth::SessionsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy validate]

  def create
    user = User.find_by!(nickname: params[:nickname])
    if user.authenticate(params[:password])
      token_data = user.create_token
      response.set_header('Authorization', "Bearer #{token_data[:token]}")
      response.set_header('X-Expired-At', token_data[:expired])
      response.set_header('X-User-Id', token_data[:user_id])
      render json: user, status: :created, serializer: UserSerializer
    else
      head :unauthorized
    end
  end

  def destroy
    token = UserToken.parse_token(request.headers['Authorization'])
    current_user.destroy_token(token)
    head :no_content
  end

  def validate
    render json: current_user
  end
end
