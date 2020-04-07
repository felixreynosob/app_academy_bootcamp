class UsersController < ApplicationController

    def index 
        if params[:query]
            @user = User.find_by(query_params)
            render :index 
        else 
            @users = User.all
            render :index
        end
    end 

    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user.id)
        else
            render :new
        end
    end

    def show 
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            redirect_to users_url
        end
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
        params.require(:user).permit(:username, :profile_picture_url)
    end
end
