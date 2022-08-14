require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "that username is valid" do
    users(:victor).update username: nil
    assert users(:victor).errors.added? :username, :blank
    assert users(:victor).errors.added? :username, :too_short, count: 3
  end
end
