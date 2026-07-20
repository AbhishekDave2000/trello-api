class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :position, :board, :archived_at, :created_at, :updated_at
end