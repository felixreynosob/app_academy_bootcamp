class SillyController < ApplicationController

    def index
        # render( json: params)
        # render( json: {key:"value"})
        render plain: "hello"
    end

    def show
        render plain: "post"
    end
    
    def create
        render plain: "create"
    end

    # def tong
    #     render json: params
    # end

end
