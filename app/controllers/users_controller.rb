class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy, :assign_workspace ]
  before_action :validate_user_before_workspace_association, only: [ :assign_workspace ]

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

  def assign_workspace
    member_record = @user.workspace_members.create(assignment_params)
    if member_record
      render json: member_record, serializer: WorkspaceMemberSerializer, status: :created
    else
      render json: { status: "error", errors: member_record.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private
  def assignment_params
    params.permit(:workspace_id, :role)
  end

  def validate_user_before_workspace_association
    unless @current_user.is_admin? || @current_user.is_manager? || @current_user.workspaces.ides.include?(params[:workspace_id])
      return render json: { error: true, message: "You don't have the access to assign the workspace." }, status: :bad_request
    end
  end

  def set_user
    @user = User.find(params[:id])
    unless @user
      render json: { error: true, message: "User not found" } and return
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_name, :password, :role)
  end
end
