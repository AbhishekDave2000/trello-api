class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:update, :destroy ]

  # GET /workspaces
  def index
    workspaces = Workspace.all
    render json: workspaces, each_serializer: WorkspaceSerializer, status: :ok
  end

  # GET /workspaces/:id
  def show
    response = params[:id].present? ? Workspace.find(params[:id]) : Workspace.wher(owner_id: params[:owner_id])
    render json: response, each_serializer: WorkspaceSerializer, status: :ok
  end

  # POST /workspaces
  def create
    workspace = Workspace.new(workspace_params)
    if workspace.save!
      render json: workspace, serializer: WorkspaceSerializer, status: :created
    else
      render json: { message: "Unable to create the workspace", errros: workspace.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  # PUT /workspaces
  def update
    if @workspace.update(workspace_params)
      render json: @workspace, serializer: WorkspaceSerializer, status: :ok
    else
      render json: { message: "Unable to update the workspace", errors: @workspace.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/:id
  def destroy
    if @workspace.destroy!
      render json: { message: "Successfully deleted the workspace" }, status: :ok
    else
      render json: { message: "Unable to delete the workspace" }, status: :unprocessable_entity
    end
  end

  private
  def workspace_params
    params.permit(:name, :slug, :description, :visibility, :owner_id)
  end

  def set_workspace
    @workspace = Workspace.find(params[:id])
  end

  def set_workspace
    @workspaces = Workspace.where(owner_id: params[:owner_id])
  end
end