class BulletPoint < ApplicationRecord
  has_many :ratings
  has_many :reviewables
  has_many :document_types, through: :reviewables
end
