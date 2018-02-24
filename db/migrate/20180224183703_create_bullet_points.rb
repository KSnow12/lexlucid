class CreateBulletPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :bullet_points do |t|
      t.text :human_title
      t.text :human_description
      t.text :lawyer_title
      t.text :lawyer_description

      t.timestamps
    end
  end
end
