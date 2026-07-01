class WorkspaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :owner_id, :description, :visibility, :created_at
end
