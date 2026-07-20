class List < ApplicationRecord
  belongs_to :board

  validates :title,    presence: true
  validates :position, presence: true
  validates :board,    presence: true

  scope :ordered, -> { order(:position) }
end