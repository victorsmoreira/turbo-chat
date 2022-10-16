require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test "that all fixtures are valid" do
    assert rooms.all?(&:valid?)
  end

  test "validations" do
    room = Room.new

    assert_not room.valid?
    assert room.errors.added? :title, :blank
    assert room.errors.added? :title, :too_short, count: 3
  end
end
