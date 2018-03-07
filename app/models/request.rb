class Request < ApplicationRecord
  validates_presence_of :title, :url
  scope :uncompleted, ->{ where(completed_at: nil) }

  def complete
    self.completed_at = Date.current
    save
  end
end
