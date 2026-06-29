class ApplicationController < ActionController::API
  before_action :authenticate_request

  private
  def authenticate_request
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id])
  rescue
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
