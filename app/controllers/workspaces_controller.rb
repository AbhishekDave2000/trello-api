class WorkspacesController < ApplicationController
  before_action :check_admin_role, only: [ :index ]
  before_action :set_workspace, only: [ :show, :update, :destroy ]

  # GET /workspaces
  def index
    workspaces = Workspace.all
    render json: workspaces, each_serializer: WorkspaceSerializer, status: :ok
  end

  # GET /workspaces/:id
  def show
    render json: @workspace, serializer: WorkspaceSerializer, status: :ok
  end

  # GET /workspaces/owner/:owner_id
  def by_owner
    workspaces = Workspace.where(owner_id: params[:owner_id])
    render json: workspaces, each_serializer: WorkspaceSerializer, status: :ok
  end

  # POST /workspaces
  def create
    workspace = Workspace.new(workspace_params)
    if workspace.save
      render json: workspace, serializer: WorkspaceSerializer, status: :created
    else
      render json: { message: "Workspace not created.", errros: workspace.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  # PUT /workspaces
  def update
    if @workspace.update(workspace_params)
      render json: @workspace, serializer: WorkspaceSerializer, status: :ok
    else
      render json: { message: "Workspace not updated.", errors: @workspace.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/:id
  def destroy
    if @workspace.destroy
      render json: { message: "Successfully deleted the workspace" }, status: :ok
    else
      render json: { message: "Workspace not deleted." }, status: :unprocessable_entity
    end
  end

  private
  def check_admin_role
    unless @current_user.admin? || @current_user.manager? || @current_user.workspaces.ids.include?(params[:workspace_id]) || @current_user.workspace_members.find_by(workspace_id: params[:workspace_id])&.role&.in?([ "admin", "manager" ])
      render json: { error: true, message: "You don't have the access to assign the workspace." }, status: :bad_request
    end
  end

  def workspace_params
    params.permit(:name, :slug, :description, :visibility, :owner_id)
  end

  def set_workspace
    @workspace = Workspace.find(params[:id])
  end
end
