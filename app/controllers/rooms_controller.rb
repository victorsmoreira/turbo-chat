class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = Room.all
  end

  def show
    @rooms = Room.order(updated_at: :desc)

    render variants: [:original] if params[:original].present?
  end

  def new
    @room = Room.new

    render turbo_stream: [
      turbo_stream.append("rooms", partial: "rooms/form", locals: { room: @room }),
      turbo_stream.update("notice")
    ]
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      render turbo_stream: [
        turbo_stream.replace("new_room", partial: "rooms/room", locals: { room: @room }),
        turbo_stream.update("notice", html: "<p class='p-2'>Room was successfully created.</p>".html_safe)
      ]
    else
      render turbo_stream: turbo_stream.replace(@room, partial: "rooms/form", locals: { room: @room }), status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { render turbo_stream: [
        turbo_stream.replace(@room, partial: "rooms/form", locals: { room: @room }),
        turbo_stream.update("notice")
      ] }
      format.html { redirect_to root_path }
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace(@room, partial: "rooms/room", locals: { room: @room }),
          turbo_stream.update("notice", html: "<p class='p-2'>Room was successfully updated.</p>".html_safe)
        ] }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@room, partial: "rooms/form", locals: { room: @room }), status: :unprocessable_entity  }
      end
    end
  end

  def destroy
    @room.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: [
        turbo_stream.remove(@room),
        turbo_stream.update("notice", html: "<p class='p-2'>Room <i>#{@room.title}</i> was deleted.</p>".html_safe)
      ] }
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
