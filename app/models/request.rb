class Request < ApplicationRecord
  scope :uncompleted, ->{ where(completed_at: nil) }
end
