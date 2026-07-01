class Workspace < ApplicationRecord
  
  # RELATIONS
  belongs_to :owner, class_name: "User"

  # VALIDATIONS
  validates :name, presence: true
  validates :visibility, presence: true
  validates :
end