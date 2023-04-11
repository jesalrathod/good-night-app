class Api::V1::ClocksController < Api::V1::BaseApiController
  #before_action :authenticate_user!

  # POST /clocks
  def create
    user = user_check_params(params[:name])
    clock = user.clocks.build(clock_in_time: Time.now)
    if clock.save
      render json: clock, status: :created
    else
      render json: clock.errors, status: :unprocessable_entity
    end
  end

  # GET /clocks
  def index
    user = user_check_params(params[:name])
    clocks = user.clocks.where(clock_out_time: nil).order(created_at: :desc)
    render json: clocks
  end

  private

  def user_check_params(params)
    params.present? ? User.find_by!(name: params) : current_user
  end

end
