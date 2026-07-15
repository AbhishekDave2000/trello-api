class BoardsController < ApplicationController
  before_action :check_admin_role, only: [ :index ]
  before_action :set_board, only: [ :show, :update, :destroy, :board_members ]

  def index
    boards = Board.all
    render json: boards, each_serializer: BoardSerializer, status: :ok
  end

  def show
    render json: @board, serializer: BoardSerializer, status: :ok
  end

  def create
    board = Board.new(board_params)
    if board.save
      render json: board, serializer: BoardSerializer, status: :created
    else
      render json: { status: "error", message: "Unable to create the board", errors: board.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def update
    if @board.update(board_params)
      render json: @board, serializer: BoardSerializer, status: :ok
    else
      render json: { message: "Unable to update the record", errors: @board.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy
    render json: { message: "Board successfully deleted." }, status: :ok
  end

  def board_members
    board_members = @board.board_members
    render json: board_members, each_serializer: BoardMemberSerializer, status: :ok
  end

  private
  def set_board
    @board = Board.find(params[:id])   
    unless @board.present?
      render json: { status: "error", message: "Can not find the Board with the provided id." }, status: :not_found
    end
    @board
  end

  def board_params
    params.permit(:title, :slug, :visibility, :owner_id, :workspace_id, :bg_color, :bg_img, :archived_at)
  end

  def check_admin_role
    unless @current_user.admin? || @current_user.manager? || @current_user.workspaces.ids.include?(params[:workspace_id]) || @current_user.workspace_members.find_by(workspace_id: params[:workspace_id])&.role&.in?([ "admin", "manager" ])
      return render json: { error: true, message: "You don't have the access to assign the workspace." }, status: :bad_request
    end
  end
end
