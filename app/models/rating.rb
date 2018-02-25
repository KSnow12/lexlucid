class Rating < ApplicationRecord
  belongs_to :bullet_point
  belongs_to :review

  validates :score, numericality: { greater_than: 0, less_than: 6 }

  def self.for_document(document)
    joins(:review).where(reviews: {document_id: document.id})
  end
end
