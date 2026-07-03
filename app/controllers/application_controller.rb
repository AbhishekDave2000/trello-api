class ApplicationController < ActionController::API
  before_action :authenticate_request

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: true, message: "Record not found" }, status: :not_found
  end

  private
  def authenticate_request
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id])
  rescue
    render json: { error: "Unauthorized Access, Try loging in again..." }, status: :unauthorized
  end
end
