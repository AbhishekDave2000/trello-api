class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :visibility, :bg_color, :bg_img, :owner_id, :workspace_id, :created_at, :updated_at
  end
end