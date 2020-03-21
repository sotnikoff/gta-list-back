class IdiotsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_record, only: %i[show update destroy restore]

  def index
    idiots = Idiot.visible
    render json: idiots, each_serializer: IdiotSerializer
  end

  def show
    render json: @idiot, serializer: IdiotSerializer
  end

  def create
    idiot = Idiot.new(permitted_attributes, author: current_user)
    if idiot.save
      render json: idiot, serializer: IdiotSerializer, status: :created
    else
      render json: idiot.errors.messages, status: :bad_request
    end
  end

  def update
    if @idiot.update(permitted_attributes)
      render json: @idiot, serializer: IdiotSerializer
    else
      render json: @idiot.errors.messages, status: :bad_request
    end
  end

  def destroy
    @idiot.discard
    head :no_content
  end

  def restore
    @idiot.undiscard
    head :no_content
  end

  def sync
    data = Idiot.sync(params[:overseer])
    render json: data
  end

  def create_or_update_batch
    params[:players].each do |player|
      idiot = Idiot.find_or_initialize_by(r_star_id: player[:r_star_id])
      idiot.name = player[:name]
      idiot.ip = player[:ip]
      idiot.author = current_user
      idiot.draft = true
      idiot.save
    end
    head :created
  end

  private

  def load_record
    @idiot = Idiot.find(params[:id])
  end

  def permitted_attributes
    params.require(:idiot).permit(:name,
                                  :death_date,
                                  :r_star_id,
                                  :pazient_diagnos,
                                  :cheats,
                                  :comment,
                                  :auto_kick,
                                  :warn_me,
                                  :freeze_player,
                                  :blame,
                                  :explode,
                                  :agressive,
                                  :mom_joke
    )
  end
end
