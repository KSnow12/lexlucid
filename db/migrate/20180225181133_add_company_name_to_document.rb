class AddCompanyNameToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :company_name, :text
  end
end
