class Rating < ApplicationRecord
  belongs_to :bullet_point
  belongs_to :review
end
