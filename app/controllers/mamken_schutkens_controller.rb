class MamkenSchutkensController < ApplicationController
  before_action :authenticate_user!

  def create
    MamkenSchutkenSmartAnalyzer.new(params[:messages], current_user).perform
    head :no_content
  end

  def index
    schutken = MamkenSchutken.by_query(params)
    render json: schutken, each_serializer: MamkenSchutkenSerializer
  end
end
