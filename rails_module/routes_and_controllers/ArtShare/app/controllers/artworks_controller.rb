class ArtworksController < ApplicationController
    def index
        render json: Artwork.all
    end
    
    def create
        if params[:artist_id]
            artwork = Artwork.new(artwork_params)
            if artwork.save
                render json: artwork 
            else 
                render json: artwork.errors.full_messages, status: :unprocessable_entity
            end
        else
           render plain: "an artist_id must be provided for authentication." 
        end
    end

    def show 
        render json: Artwork.find(params[:id])
    end
    
    def update
        artwork = Artwork.find(params[:id])
        if artwork.update(artwork_params)
            render json: artwork 
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        render json: Artwork.destroy(params[:id])
    end

    private
    
    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end
end