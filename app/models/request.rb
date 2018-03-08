class Request < ApplicationRecord
  validates_presence_of :title, :url
  scope :uncompleted, ->{ where(completed_at: nil) }

  def complete
    self.completed_at = Date.current
    save
  end

  def nice_completed_at
    return if completed_at.blank?
    completed_at.strftime("%b %-d, %Y %r")
  end
end
