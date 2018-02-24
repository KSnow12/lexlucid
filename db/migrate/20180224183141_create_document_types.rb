class CreateDocumentTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :document_types do |t|
      t.text :category

      t.timestamps
    end
  end
end
