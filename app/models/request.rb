class Request < ApplicationRecord
  validates_presence_of :title, :url
  scope :uncompleted, ->{ where(completed_at: nil) }
end
