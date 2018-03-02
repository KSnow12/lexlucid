class User < ApplicationRecord
  has_many :reviews
  validates_uniqueness_of :email
  has_secure_password

  def has_reviewed_document?(document)
    document.reviews.where(user_id: self.id).exists?
  end

  def website
    the_url = super
    if the_url =~ %r{^https?://} || the_url.blank?
      the_url
    else
      "http://#{the_url}"
    end
  end
end
