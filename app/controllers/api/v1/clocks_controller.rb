class Api::V1::ClocksController < Api::V1::BaseApiController
  #before_action :authenticate_user!

  # POST /clocks
  def create
    user = user_check_params(params[:name])
    clock = user.clocks.build(clock_in_time: Time.now, clock_out_time:  Time.now + 2.hours)
    if clock.save
      render json: clock, status: :created
    else
      render json: clock.errors, status: :unprocessable_entity
    end
  end

  # GET /clocks
  def index
    user = user_check_params(params[:name])
    clocks = user.clocks.order(created_at: :desc)
    render json: clocks
  end

  def user_sleep_records
    user = user_check_params(params[:name])
    sleep_records = []
    user&.followees.each do |friend|
      sleep_records += friend.clocks.where(created_at: 1.week.ago..Time.now)
      sleep_records = sleep_records.sort_by { |record| [friend.name, record.created_at.strftime("%d/%m/%Y"), record.sort_by_sleep_duration] }.reverse
    end
    render json: sleep_records
  end

  private

  def user_check_params(params)
    params.present? ? User.find_by!(name: params) : current_user
  end

end
