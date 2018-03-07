class Review < ApplicationRecord
  belongs_to :user
  belongs_to :document
  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :ratings, reject_if: ->(attributes) {attributes[:bullet_point_id].blank? && attributes[:bullet_point_id].blank? && attributes[:description].blank?}

  validate :minimum_one_rating
  validate :require_attorney_affiliated_checkbox

  attr_accessor :attorney_not_affiliated

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

  def self.find_review_for(document, user_email)
    user = User.find_by_email(user_email)
    return nil if !document || !user || !document.reviews.any?

    document.reviews.where(user_id: user.id).first
  end

  private

  # validates
  def minimum_one_rating
    if ratings.size <= 0
      errors.add(:ratings, "- You must grade at least one issue to submit a review")
    end
  end

  # validates
  def require_attorney_affiliated_checkbox
    if !ActiveModel::Type::Boolean.new.cast(attorney_not_affiliated)
      errors.add(:attorney_not_affiliated, "is required")
    end
  end
end
