class RemoveBulletPointAttrs < ActiveRecord::Migration[5.1]
  def change
    remove_column :bullet_points, :lawyer_description
    remove_column :bullet_points, :lawyer_title
  end
end
