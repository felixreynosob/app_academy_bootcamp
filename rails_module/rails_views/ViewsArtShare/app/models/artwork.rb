class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true
    validates :artist_id, presence: true
    validates :artist_id, uniqueness: { scope: :title, 
        message: "An artist can't have two artworks with the same title." }
    
    belongs_to :artist,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: 'User'

    has_many :artwork_shares,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: 'ArtworkShare'
        
    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer
    
    has_many :comments,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: 'Comment'

    def self.artworks_for_user_id(user_id) 
        Artwork
        .left_outer_joins(:artwork_shares)
        .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
        .distinct
    end
end