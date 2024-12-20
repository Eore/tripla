class SleepLogsController < ApplicationController
  before_action :set_sleep_log, only: %i[ show update destroy ]

  # GET /sleep_logs
  def index
    @sleep_logs = SleepLog.all

    render json: @sleep_logs
  end

  # GET /sleep_logs/1
  def show
    render json: @sleep_log
  end

  # POST /sleep_logs
  def create
    @sleep_log = SleepLog.new(sleep_log_params)

    if @sleep_log.save
      render json: @sleep_log, status: :created, location: @sleep_log
    else
      render json: @sleep_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sleep_logs/1
  def update
    if @sleep_log.update(sleep_log_params)
      render json: @sleep_log
    else
      render json: @sleep_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sleep_logs/1
  def destroy
    @sleep_log.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sleep_log
      @sleep_log = SleepLog.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def sleep_log_params
      params.expect(sleep_log: [ :clock_in, :clock_out, :users_id ])
    end
end
