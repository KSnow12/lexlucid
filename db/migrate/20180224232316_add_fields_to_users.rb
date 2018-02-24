class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :states, :string
    add_column :users, :attorney_registration_number, :string
  end
end
