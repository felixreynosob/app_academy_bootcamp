class ArtworkShare < ApplicationRecord
    validates :artwork_id, presence: true
    validates :viewer_id, presence: true
    validates :artwork_id, uniqueness: { scope: :viewer_id, 
        message: " can't be shared with a user more than once."}
    
    belongs_to :artwork
    belongs_to :viewer, class_name: 'User'
end