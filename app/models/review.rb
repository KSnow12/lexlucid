class Review < ApplicationRecord
  belongs_to :user
  belongs_to :document
  has_many :ratings

  accepts_nested_attributes_for :ratings, reject_if: ->(attributes) {attributes[:bullet_point_id].blank? && attributes[:bullet_point_id].blank? && attributes[:description].blank?}

  def self.summarize_scores(document)
    Rating.joins(:review).
    select("""
      AVG(score) AS avg_score,
      bullet_point_id,
      COUNT(bullet_point_id) AS reviews_done
    """).
    group(:bullet_point_id).
    where("reviews.document_id = ?", document.id).
    order("COUNT(bullet_point_id) DESC").
    preload(:bullet_point).
    limit(5)
  end
end
