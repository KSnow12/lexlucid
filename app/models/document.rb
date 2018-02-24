class Document < ApplicationRecord
  belongs_to :document_type
  has_many :reviews
end
