class CreateReviewables < ActiveRecord::Migration[5.1]
  def change
    create_table :reviewables do |t|
      t.references :document_type, foreign_key: true, null: false
      t.references :bullet_point, foreign_key: true, null: false
      t.integer :position, default: 1, null: false
      t.timestamps
    end
  end
end
