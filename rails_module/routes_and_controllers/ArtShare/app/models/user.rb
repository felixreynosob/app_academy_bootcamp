class User < ApplicationRecord
    validates :username, presence: true, uniqueness:true
    validate :check_username_length

    has_many :artworks,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: "Artwork"
    
    def check_username_length
        if self.username.length < 4
            errors[:username] << "must be 4 characters or longer."
        end
    end

end