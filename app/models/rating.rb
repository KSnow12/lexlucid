class Rating < ApplicationRecord
  belongs_to :bullet_point
  belongs_to :review

  validates :score, numericality: { greater_than: 0, less_than: 6 }
end
