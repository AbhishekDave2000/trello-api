class Workspace < ApplicationRecord
  # RELATIONS
  belongs_to :owner, class_name: "User"

  # VALIDATIONS
  validates :name, presence: { message: "is required" },
                  uniqueness: { message: "is already taken" }
  validates :visibility, presence: true
end
