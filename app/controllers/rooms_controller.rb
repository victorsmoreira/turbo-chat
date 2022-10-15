class RoomsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to rooms_path, notice: "Room was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@room), partial: "rooms/index/form", locals: { room: @room }) }
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@room), partial: "rooms/index/room", locals: { room: @room }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@room), partial: "rooms/index/form", locals: { room: @room }), status: :unprocessable_entity  }
      end
    end
  end

  def destroy
    @room.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@room)) }
    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:title)
    end
end
