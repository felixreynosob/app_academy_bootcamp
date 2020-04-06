class UsersController < ApplicationController

    def index 
        if params[:query]
            render json: User.find_by(query_params)
            # render json: params
        else 
            render json: User.all
        end
    end 

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show 
        render json: User.find(params[:id])
    end

    def update 
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user
        else
            render json: useer.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        render json: User.destroy(params[:id])
    end

    private

    def query_params
        params.require(:query).permit(:username, :id)
    end

    def user_params
        params.require(:user).permit(:username)
    end
end