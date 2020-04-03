class UsersController < ApplicationController
    protect_from_forgery

    def index
        # render json: Person.all
        render json: params
        # render plain:"<html><body><h1>Hello</h1><img src=https://m.media-amazon.com/images/M/MV5BZmQ5NGFiNWEtMmMyMC00MDdiLTg4YjktOGY5Yzc2MDUxMTE1XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_UY1200_CR93,0,630,1200_AL_.jpg></body></html>"
    end

    def show
        render json: Person.find(params["id"])
        # render json: params["id"]
    end

    def create
        # render plain: "post"
        person = Person.new
        person.name = params["name"]
        person.house_id = params["house_id"]
        person.save
        render json: person
    end
end