class User < ApplicationRecord
    validates :username, presence: true
    validates :username, uniqueness: true
    validate :check_username_length
    
    def check_username_length
        if self.username.length < 4 
            errors[:username] << "must be 4 characters or longer."
        end
    end

    has_many :artworks,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: 'Artwork',
        dependent: :destroy

    has_many :artwork_shares,
        primary_key: :id,
        foreign_key: :viewer_id,
        class_name: 'ArtworkShare',
        dependent: :destroy

    has_many :shared_artworks,
        through: :artwork_shares,
        source: :artwork
    
    has_many :comments,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: 'Comment'

end