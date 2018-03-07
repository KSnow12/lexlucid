class AddAndRemoveFieldsForRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :request_id, :integer
    remove_column :requests, :description
  end
end
