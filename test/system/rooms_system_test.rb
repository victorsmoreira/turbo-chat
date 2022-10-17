# frozen_string_literal: true

require "application_system_test_case"

class RoomsSystemTest < ApplicationSystemTestCase
  test "that rooms can be edited" do
    visit rooms_path

    assert_selector "h2", text: "Room one"

    within("##{dom_id(rooms(:one))}") { click_link "Edit" }
    assert_selector "input[name='room[title]'][value='Room one']"

    fill_in "room[title]", with: "Change title"
    click_button "Save room title"

    within("##{dom_id(rooms(:one))}") { assert_selector "h2", text: "Change title" }
  end

  test "that rooms can be deleted" do
    visit rooms_path

    assert_selector "h2", text: "Room one"
    within("##{dom_id(rooms(:one))}") do
      accept_confirm do
        click_link "Delete"
      end
    end

    assert_no_selector "h2", text: "Room one"
  end
end
