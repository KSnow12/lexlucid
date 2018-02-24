class AddDocumentToReview < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :document, foreign_key: true
  end
end
