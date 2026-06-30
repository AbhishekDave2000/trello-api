class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.where(role: [:manager, :member])
    render json: { data: users }, status: :success
  end

  def show
    render json: { data: @user }, status: :success
  end

  def create
    user =  User.create(user_params)
    if user.persist?
      render json: { data: user, message: "User Successfully Created" }, status: :success
    end
  end

  def update
    if @user.update(params[:user_params])
      render json: { data: @user, message: "User Updated Successdfully" }, status: :success
    else
      render json: { error: @user.errors.full_messages.join(", "), message: "Can not update the user" }, status: :error
    end
  end

  def destroy
    if @user.destroy 
      render json: { message: "Successfully Deleted." }, status: :no_content
    else
      render json: { message: "Unable to delete the user", data: UserSerializer.new(@user).as_json  }, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find_by(params[:id])
    unless @user return render json: { error: true, message: "Can not find the user" }
  end
end
