class BoardMember < ApplicationRecord
  belongs_to :board, class_name: "Board"
  belongs_to :user, class_name: "User"

  enum :role, { member: 0, manager: 1, admin: 2, guest: 3 }

  validates :role, presence: true
end
