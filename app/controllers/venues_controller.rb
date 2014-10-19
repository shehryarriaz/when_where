class VenuesController < ApplicationController
  def show
    @venue = Venue.find(params[:id])

    respond_to do |format|
      format.json { render json: @venue }
    end
  end
end
