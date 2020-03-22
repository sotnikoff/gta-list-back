class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.by_filter(params)
    render json: users, each_serializer: UserSerializer
  end
end
