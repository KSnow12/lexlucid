class Review < ApplicationRecord
  #belongs_to :lawyer
  belongs_to :document
  has_many :ratings
end
