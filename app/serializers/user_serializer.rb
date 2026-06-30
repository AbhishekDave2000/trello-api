class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :created_at, :updated_at

  attribute :role_label

  def role_label
    object&.role&.titleize
  end
end
