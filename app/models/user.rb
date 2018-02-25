class User < ApplicationRecord
  has_many :reviews
  validates_uniqueness_of :email
  has_secure_password
end
