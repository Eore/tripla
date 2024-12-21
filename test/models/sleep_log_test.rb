require "test_helper"

class SleepLogTest < ActiveSupport::TestCase
  setup do
    @user = users(:miaw)
  end

  test "should not save if clock_in is empty" do
    sleep_log = SleepLog.new(user: @user)
    assert_not sleep_log.save
  end

  test "should not save if clock_in is empty and clock_out is not empty" do
    sleep_log = SleepLog.new(clock_out: Time.now, user: @user)
    assert_not sleep_log.save
  end

  test "should set duration if clock_in and clock_out is not empty" do
    sleep_log = SleepLog.create(clock_in: Time.now, clock_out: Time.now + 60, user: @user)
    assert_equal 60, sleep_log.duration.to_i
  end
end
