class Document < ApplicationRecord
  belongs_to :document_type
  has_many :reviews

  def self.search(query)
    where("documents.name ILIKE :query", query: "%#{query}%")
  end
end
