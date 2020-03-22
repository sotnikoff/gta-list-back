class Auth::InvitationsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    user = User.invite(params[:email], current_user)
    if user.errors.any?
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    else
      render json: user, serializer: UserSerializer
    end
  end

  def proceed
    user = User.find_by!(invitation_token: permitted_params[:token])
    user.invitation_token = nil
    user.password = permitted_params[:password]
    user.password_confirmation = permitted_params[:password_confirmation]
    user.nickname = permitted_params[:nickname]
    if user.save
      render json: user, serializer: UserSerializer
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  def user_by_token
    user = User.find_by!(invitation_token: params[:token])
    render json: user, serializer: UserSerializer
  end

  private

  def permitted_params
    params.require(:user).permit(:token, :nickname, :password, :password_confirmation)
  end
end
