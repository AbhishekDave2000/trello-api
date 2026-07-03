class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]

  # GET /users
  def index
    users = User.where(role: [ :manager, :member ])
    render json: users, each_serializer: UserSerializer, status: :ok
  end

  def show
    render json: @user, serializer: UserSerializer, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, serializer: UserSerializer, status: :created
    else
      render json: {  message: "Unable to create the user", error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, serializer: UserSerializer, status: :ok
    else
      render json: { message: "Unable to update the user", error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy!
      render json: { message: "Successfully deleted." }, status: :no_content
    else
      render json: { message: "Unable to delete user" }, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
    unless @user
      render json: { error: true, message: "User not found" } and return
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_name,  :password, :role)
  end
end
