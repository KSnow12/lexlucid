class DocumentType < ApplicationRecord
  has_many :documents
  has_many :reviewables, dependent: :destroy
  has_many :bullet_points, through: :reviewables

  validates_presence_of :category
end
