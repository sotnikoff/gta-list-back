class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_record, only: %i[update destroy]

  def index
    profiles = Profile.all
    render json: profiles, each_serializer: ProfileSerializer
  end

  def create
    profile = Profile.new(permitted_attributes)
    profile.author = current_user
    if profile.save
      render json: profile, serializer: ProfileSerializer
    else
      render json: profile.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(permitted_attributes)
      render json: @profile, serializer: ProfileSerializer
    else
      render json: @profile.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    head :no_content
  end

  private

  def permitted_attributes
    params.require(:profile).permit(:name, :r_star_id)
  end

  def load_record
    @profile = Profile.find(params[:id])
  end
end
