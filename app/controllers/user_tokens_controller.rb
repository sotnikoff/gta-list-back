class UserTokensController < ApplicationController
  before_action :authenticate_user!

  def create
    token = UserToken.create_api_token(current_user)
    render json: token, serializer: UserTokenSerializer
  end

  def index
    tokens = UserToken.api_tokens(current_user)
    render json: tokens, each_serializer: UserTokenSerializer
  end

  def destroy
    token = UserToken.find(params[:id])
    token.destroy
    head :no_content
  end
end
