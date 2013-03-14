class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @place = Place.find(params[:place_id])
    @review = @place.reviews.create(params[:review])
    redirect_to place_path(@place)
  end
  
end
