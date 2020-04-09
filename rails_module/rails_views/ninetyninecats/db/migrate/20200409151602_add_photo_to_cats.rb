class AddPhotoToCats < ActiveRecord::Migration[5.2]
  def change
    add_column(:cats, :picture_url, :string)
  end
end
