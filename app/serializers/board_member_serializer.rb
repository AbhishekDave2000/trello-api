class BoardMemberSerializer < ActiveModel::Serializer
  attributes :id, :board_id, :user_id, :role, :created_at, :updated_at
end