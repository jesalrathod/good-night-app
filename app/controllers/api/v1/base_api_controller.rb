class Api::V1::BaseApiController < ApplicationController
  #include JSONAPI::ActsAsResourceController
  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :authenticate_user!
  rescue_from StandardError, with: :handle_error

  def current_user
    @current_user ||= User.find_or_create_by(name: params[:name])
  end

  private

  def authenticate_user!
    render json: { error: 'Not authorized' }, status: :unauthorized unless current_user
  end

  def handle_error(exception)
    Rails.logger.error(exception.message)
    Rails.logger.error(exception.backtrace.join("\n"))

    error_response = { error: { message: exception.message } }
    error_response[:error][:status] = :unprocessable_entity if exception.is_a?(ActiveRecord::RecordInvalid)

    render json: error_response, status: error_status(exception)
  end

  def error_status(exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      :not_found
    elsif exception.is_a?(ActionController::ParameterMissing)
      :unprocessable_entity
    else
      :internal_server_error
    end
  end
end
