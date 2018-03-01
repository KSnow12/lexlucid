class Document < ApplicationRecord
  belongs_to :document_type
  has_many :reviews, dependent: :destroy
  validates_uniqueness_of :url

  def self.search(query)
    scope = includes(:document_type, :reviews)

    if query.present?
      scope = scope.where("documents.name ILIKE :query OR documents.company_name ILIKE :query", query: "%#{query}%")
    end

    scope.all.order("company_name DESC")
  end

  def url
    the_url = super
    if the_url =~ %r{^https?://} || the_url.blank?
      the_url
    else
      "http://#{the_url}"
    end
  end

  def overall_score
    @overall_score ||= begin
      scores = Review.summarize_scores(self).map(&:avg_score)
      return nil if scores.empty?
      scores.sum / scores.size
    end
  end
end
