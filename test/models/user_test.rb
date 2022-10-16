require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "that all fixtures are valid" do
    assert users.all?(&:valid?)
  end

  test "validations" do
    users(:victor).update username: nil
    assert users(:victor).errors.added? :username, :blank
    assert users(:victor).errors.added? :username, :too_short, count: 3
  end
end
