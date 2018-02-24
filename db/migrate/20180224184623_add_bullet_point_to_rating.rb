class AddBulletPointToRating < ActiveRecord::Migration[5.1]
  def change
    add_reference :ratings, :bullet_point, foreign_key: true
  end
end
