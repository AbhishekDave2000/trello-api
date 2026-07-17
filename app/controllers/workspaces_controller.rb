class WorkspacesController < ApplicationController
  before_action :check_admin_role, only: [ :index, :workspace_members ]
  before_action :set_workspace, only: [ :show, :update, :destroy, :workspace_members ]

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

  def workspace_members
    workspace_members = @workspace.workspace_members
    render json: workspace_members, each_serializer: WorkspaceMemberSerializer, status: :ok
  end

  private
  def check_admin_role
    workspace_id = params[:workspace_id] || params[:id]
    unless workspace_owner?(workspace_id) || workspace_manager?(workspace_id)
      return render json: { error: true, message: "You don't have the access to assign the workspace. If you think this is wrong please contact your admin or the manager." }, status: :bad_request
    end
  end

  def workspace_owner?(workspace_id)
    return true if @current_user.admin? || @current_user.workspaces.exists?(workspace_id)
  end

  def workspace_manager?(workspace_id)
    return true if @current_user.manager? || @current_user.workspace_members.find_by(workspace_id: workspace_id)&.role&.in?([ "admin", "manager" ])
  end

  def workspace_params
    params.permit(:name, :slug, :description, :visibility, :owner_id)
  end

  def set_workspace
    @workspace = Workspace.find(params[:id])
  end
end
