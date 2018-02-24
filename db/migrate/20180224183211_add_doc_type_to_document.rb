class AddDocTypeToDocument < ActiveRecord::Migration[5.1]
  def change
    add_reference :documents, :document_type, foreign_key: true
  end
end
