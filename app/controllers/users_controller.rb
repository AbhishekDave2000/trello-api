class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy, :assign_workspace, :assign_board ]
  before_action :validate_user_before_workspace_association, only: [ :assign_workspace ]
  before_action :validate_user_before_board_association, only: [ :assign_board ]

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
    member_record = @user.workspace_members.create(workspace_assignment_params)
    if member_record
      render json: member_record, serializer: WorkspaceMemberSerializer, status: :created
    else
      render json: { status: "error", errors: member_record&.errors&.full_messages&.join(", ") }, status: :unprocessable_entity
    end
  end

  def assign_board
    member_record = @user.board_members.create(board_assignment_params)
    if member_record
      render json: member_record, serializer: BoardMemberSerializer, status: :created
    else
      render json: { status: "error", errors: member_record&.errors&.full_messages&.join(", ") }, status: :unprocessable_entity
    end
  end

  private
  def workspace_assignment_params
    params.permit(:workspace_id, :role)
  end

  def board_assignment_params
    params.permit(:board_id, :role)
  end

  def validate_user_before_workspace_association
    unless @current_user.admin? || @current_user.manager? || @current_user.workspaces.ids.include?(params[:workspace_id]) || @current_user.workspace_members.find_by(workspace_id: params[:workspace_id])&.role&.in?([ "admin", "manager" ])
      render json: { error: true, message: "You don't have the appropriate access, Contact admin or your mnanager if you have query." }, status: :bad_request
    end
  end

  def validate_user_before_board_association
    unless @current_user.admin? || @current_user.manager? || @current_user.boards.ids.include?(params[:board_id]) || @current_user.board_members.find_by(board_id: params[:board_id])&.role&.in?([ "admin", "manager" ])
      render json: { error: true, message: "You don't have the appropriate access, Contact admin or your mnanager if you have query." }, status: :bad_request
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
