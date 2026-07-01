class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [ :show, :update, :destroy ]

  # GET /workspaces
  def index
    workspaces = Workspace.all
  end

  # GET /workspaces/:id
  def show
    response = params[:id].present? ? @workspace : @workspaces
    render json: response, serializer: WorkspaceSerializer, status: :ok
  end

  def create
  end

  private
  def workspace_params
    params.permit(:name, :slug, :description, :visibility, :owner_id)
  end

  def set_workspace
    @workspace = Workspace.find_by(id: params[:id])
  end

  def set_workspace
    @workspaces = Workspace.where(owner_id: params[:owner_id])
  end
end
