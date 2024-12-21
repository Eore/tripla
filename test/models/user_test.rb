require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save if name is empty" do
    user = User.new
    assert_not user.save
  end
end
