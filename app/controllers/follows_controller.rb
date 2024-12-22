class FollowsController < ApplicationController
  # GET /follows/:user_id
  def show
    user_id = params.expect(:user_id)
    @follow = Follow
      .where(user_id: user_id)
      .page(params[:page] || 1)
      .per(params[:size] || 50)

    render json: @follow
  end

  # POST /follows
  def create
    @follow = Follow.new(follow_params)

    if @follow.save
      render json: @follow, status: :created
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /follows/1
  def destroy
    @follow = Follow.find(params.expect(:id))

    @follow.destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def follow_params
      params.expect(follow: [ :user_id, :follow_id ])
    end
end
