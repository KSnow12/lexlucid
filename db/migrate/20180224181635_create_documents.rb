class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.text :name
      t.text :url
      t.text :description
      t.date :published_on

      t.timestamps
    end
  end
end
