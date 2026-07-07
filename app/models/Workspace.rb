class Workspace < ApplicationRecord
  # RELATIONS
  belongs_to :owner, class_name: "User"
  has_many :workspace_members, foreign_key: :workspace_id

  # VALIDATIONS
  validates :name, presence: { message: "is required" },
                  uniqueness: { message: "is already taken" }
  validates :visibility, presence: true
end
