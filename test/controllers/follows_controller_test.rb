require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:lala)
    @follow = users(:miaw)
  end

  test "should follow correctly" do
    url = "/follows"
    params = { follow: { follow_id: @follow.id, user_id: @user.id } }
    post url, params: params, as: :json

    assert_response :created
  end

  test "should failed on self follow" do
    url = "/follows"
    params = { follow: { follow_id: @user.id, user_id: @user.id } }
    post url, params: params, as: :json

    assert_response :unprocessable_entity
  end

  test "should failed on double follow" do
    url = "/follows"
    params = { follow: { follow_id: @follow.id, user_id: @user.id } }
    post url, params: params, as: :json
    post url, params: params, as: :json

    assert_response :unprocessable_entity
  end

  test "should failed on empty follow" do
    url = "/follows"
    params = { follow: { user_id: @user.id } }
    post url, params: params, as: :json

    assert_response :unprocessable_entity
  end

  test "should failed on empty user" do
    url = "/follows"
    params = { follow: { follow_id: @follow.id } }
    post url, params: params, as: :json

    assert_response :unprocessable_entity
  end

  test "should success unfollow user" do
    url = "/follows/#{follows(:miaw_follow).id}"
    delete url, as: :json

    assert_response :no_content
    assert_equal 0, Follow.where(user_id: users(:miaw).id).count
  end

  test "should success show the follow list" do
    url = "/follows/#{users(:miaw).id}"
    get url, as: :json

    assert_response :ok
    list = JSON.parse(response.body)
    assert_equal 1, list.length
  end
end
