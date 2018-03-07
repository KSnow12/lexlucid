class AddBooleansToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :auto_accept, :boolean
    add_column :documents, :notify_on_changes, :boolean
  end
end
