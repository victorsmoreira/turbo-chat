# frozen_string_literal: true

require "test_helper"

class RoomsTest < ActionDispatch::IntegrationTest
  test "index layout" do
    get rooms_path

    assert_select "h1", text: "Rooms"
    assert_select ".room", count: rooms.count
    assert_select "##{dom_id(rooms(:one))}" do
      assert_select "a[href=?]", room_path(rooms(:one))
      assert_select "a[data-turbo-stream='true'][href=?]", edit_room_path(rooms(:one))
      assert_select "a[data-turbo-method='delete'][href=?]", room_path(rooms(:one))
    end
    assert_select "a[href=?]", new_room_path, text: "Create a room"
  end
end
