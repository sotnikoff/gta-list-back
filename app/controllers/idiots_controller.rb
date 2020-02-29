class IdiotsController < ApplicationController
  def index
    idiots = Idiot.all
    render json: idiots, each_serializer: IdiotSerializer
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
