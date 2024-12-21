require "test_helper"

class FollowTest < ActiveSupport::TestCase
  setup do
    @user = users(:miaw)
    @follow = users(:nyan)
  end


  test "should not save if user_id is empty or follow_id is empty" do
    follow = Follow.new
    assert_not follow.save
  end

  test "should not save if user_id is empty" do
    follow = Follow.new(follow: @follow)
    assert_not follow.save
  end

  test "should not save if follow_id is empty" do
    follow = Follow.new(user: @user)
    assert_not follow.save
  end

  test "should not save if follow itself" do
    follow = Follow.new(user: @user, follow: @user)
    assert_not follow.save
  end

  test "should not save if follow same user again" do
    Follow.create(user: @user, follow: @follow)
    follow = Follow.new(user: @user, follow: @follow)
    assert_not follow.save
  end
end
