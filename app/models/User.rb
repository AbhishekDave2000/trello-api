class User < ApplicationRecord
  has_secure_password

  # RELATIONS
  has_many :workspaces, foreign_key: :owner_id
  has_many :workspace_members, foreign_key: :user_id

  enum :role, { member: "member", admin: "admin", manager: "manage r" }

  # ACTION CALLBACKS
  before_validation :set_role, on: :create

  # VALIDATIONS
  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true

  private
  def set_role
    self.role ||= :member
  end

  def is_admin?
    self.admin?
  end

  def is_manager?
    self.manager?
  end
end
