class CommentsController < ApplicationController
    def index
        case
        when params[:user_id]
            render json: User.find(params[:user_id]).comments
        when params[:artwork_id]
            render json: Artwork.find(params[:artwork_id]).comments
        else 
            render json: Comment.all
        end
    end

    def create
        comment = Comment.create(comment_params)
        if comment.save
            render json: comment, status: :created
        else 
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        render json: Comment.destroy(params[:id])
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :user_id, :artwork_id)
    end
end