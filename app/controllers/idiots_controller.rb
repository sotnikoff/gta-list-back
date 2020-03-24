class IdiotsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_record, only: %i[show update destroy restore]

  def index
    idiots = Idiot.query(params)
    render json: idiots, each_serializer: IdiotSerializer
  end

  def show
    render json: @idiot, serializer: IdiotSerializer
  end

  def create
    idiot = Idiot.new(permitted_attributes.merge(author: current_user))
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
    CreateOrUpdatePlayers.call(params[:players], current_user)
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
                                  :ip,
                                  :explode,
                                  :streamer,
                                  :agressive,
                                  :mom_joke
    )
  end
end
