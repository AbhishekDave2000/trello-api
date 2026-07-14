class Board < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :workspace

  has_many :board_members, foreign_key: :board_id

  enum :visibility, { 
    board_private: 0, 
    board_internal: 1, 
    board_public: 2 
  }

  validates :title, presence: { message: "is required" },
                    uniqueness: { message: "is already taken" }
  validates :slug, presence: true
  validates :visibility, presence: true
end
