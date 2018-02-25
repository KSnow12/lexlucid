class AddVersionToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :version, :string
    remove_column :documents, :published_on
  end
end
