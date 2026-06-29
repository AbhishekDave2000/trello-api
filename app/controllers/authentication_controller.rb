class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [ :login, :register ]

  # Registration Method
  def register
    user = User.create(user_params)
    JsonWebToken.encode(user_id: user.id)
    render json: { token: token, user: UserSerializer.new(user).as_json }, status: :created
  end

  # Login Method
  def login
    user = User.find_by!(email: params[:email].downcase)

    if user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: UserSerializer.new(user).as_json }, status: :ok
    else
      render json: { error: "Invalid Password" }, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:name, :user_name, :email, :passowrd, :role)
  end
end
