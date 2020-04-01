class SillyController < ApplicationController

    def fun
        render json: params
    end
end
