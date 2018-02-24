class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      #t.references :lawyer, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
