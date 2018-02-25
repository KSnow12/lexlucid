class User < ApplicationRecord
  has_many :reviews
  validates_uniqueness_of :email
  has_secure_password

  def has_reviewed_document?(document)
    document.reviews.map(&:user_id).include?(self.id)
  end
end
