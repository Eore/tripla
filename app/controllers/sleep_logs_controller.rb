class SleepLogsController < ApplicationController
  # POST /clock/:user_id
  def clock
    user_id = params.expect(:user_id)
    @sleep_log = SleepLog.where(user_id: user_id).order(clock_in: :desc).find_by(clock_out: nil)

    if @sleep_log
      @sleep_log.clock_out = Time.now
    else
      @sleep_log = SleepLog.new(user_id: user_id, clock_in: Time.now)
    end

    unless @sleep_log.save
      render json: @sleep_log.errors, status: :unprocessable_entity
      return
    end

    @sleep_log = SleepLog.where(user_id: user_id).order(clock_in: :asc)

    render json: @sleep_log
  end

  # GET /sleep_logs/:user_id
  def show
    user_id = params.expect(:user_id)
    follow_ids = User
      .find_by(id: user_id)
      .follows.pluck(:follow_id)
      .push(user_id)
    @sleep_log = SleepLog
      .where(user_id: follow_ids)
      .where.not(duration: nil)
      .order(duration: :desc)

    render json: @sleep_log
  end
end
