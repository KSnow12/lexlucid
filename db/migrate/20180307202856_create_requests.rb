class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.text :title
      t.text :url
      t.text :description
      t.datetime :completed_at

      t.timestamps
    end
  end
end
