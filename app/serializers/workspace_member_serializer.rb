class WorkspaceMemberSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :workspace_id, :role
end
