require "test_helper"

class SleepLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:miaw)
  end

  test "should properly clock in" do
    url = "/clock/#{@user.id}"
    post url, as: :json 
    new_log = SleepLog.last

    assert_response :ok
    assert new_log.clock_out.nil?
  end

  test "should properly clock out" do
    url = "/clock/#{@user.id}"
    post url, as: :json 
    new_log = SleepLog.last

    assert_response :ok
    assert new_log.clock_out.nil?

    post url, as: :json 

    new_log = SleepLog.last
    assert_response :ok
    assert new_log.clock_out
    assert new_log.duration
  end

  test "should return correct sleep logs" do  
    url = "/sleep_logs/#{@user.id}"

    get url, as: :json

    assert_response :ok

    new_log = JSON.parse(response.body)
    assert_equal 2, new_log.length
    new_log.each do |log|
      assert [users(:miaw).id, users(:nyan).id].include?(log["user_id"])
    end
  end
end
