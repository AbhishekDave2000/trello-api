class WorkspaceMember < ApplicationRecord
  belongs_to :workspace
  belongs_to :user

  enum :role, { member: 0, manager: 1, admin: 2, guest: 3 }

  validates :role, presence: true
end
