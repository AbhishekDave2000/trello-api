class User < ApplicationRecord
  has_secure_password
  before_validation :set_role, on: :create

  enum :role, { member: "member", admin: "admin", guest: "guest" }

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
end