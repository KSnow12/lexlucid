class Reviewable < ApplicationRecord
  belongs_to :document_type
  belongs_to :bullet_point
end
