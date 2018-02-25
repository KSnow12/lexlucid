class Review < ApplicationRecord
  belongs_to :user
  belongs_to :document
  has_many :ratings

  accepts_nested_attributes_for :ratings

  def self.summarize_scores(document)
    Rating.joins(:review).
    select("""
      AVG(score) AS score,
      bullet_point_id
    """).
    group(:bullet_point_id).
    where("reviews.document_id = ?", document.id).
    order("COUNT(bullet_point_id) DESC").
    preload(:bullet_point).
    limit(5)
    #Review.select("""
#
    #""").
    #group(:user_id).
    #where(document_id: document.id).
    #order("COUNT(")
  end
end
