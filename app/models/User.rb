class User < ApplicationRecord
  has_secure_password

  rnum role: {
    admin: 0,
    manager: 1
    member: 2,
  }

  validates :name, presence: true
  validates :email,  
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, 
            presence: true,
            length: { minimum: 6 },
            if: :password_required?
  validates role: presence: true

  private
  def password_required?
    password_digest.blank? || !password.nil?
  end
end