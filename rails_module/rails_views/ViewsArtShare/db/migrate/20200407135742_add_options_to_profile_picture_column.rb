class AddOptionsToProfilePictureColumn < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :profile_picture_url, false
  end
end
