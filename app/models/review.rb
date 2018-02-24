class Review < ApplicationRecord
  belongs_to :user
  belongs_to :document
  has_many :ratings

  accepts_nested_attributes_for :ratings
end
