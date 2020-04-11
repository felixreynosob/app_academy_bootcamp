class CatRentalRequestsController < ApplicationController

  def new
    render :new
  end

  def create
    cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    cat_rental_request.cat_id = params[:cat_id]
    
    if cat_rental_request.save
      redirect_to cat_url(Cat.find_by(id: cat_rental_request.cat_id))
    else
      render :new
    end
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
