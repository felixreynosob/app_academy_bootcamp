class AddConstraintToPictureColumnInCats < ActiveRecord::Migration[5.2]
  def change
    change_column :cats, :picture_url, :string, null: false
  end
end
