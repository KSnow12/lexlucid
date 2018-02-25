class Document < ApplicationRecord
  belongs_to :document_type
  has_many :reviews

  def self.search(query)
    scope = includes(:document_type, :reviews)

    if query.present?
      scope = scope.where("documents.name ILIKE :query", query: "%#{query}%")
    end

    scope.all
  end

  def url
    the_url = super
    if the_url =~ %r{^https?://}
      the_url
    else
      "http://#{the_url}"
    end
  end
end
