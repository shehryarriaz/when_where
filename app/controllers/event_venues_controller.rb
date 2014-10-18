class EventVenuesController < ApplicationController

  def show
    @event_venue = EventVenue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_venue }
    end
  end

  def create
    @event_suggestion = EventSuggestion.find(params[:event_suggestion_id])
    @name = params[:name]
    @address = params[:address]
    @venue = Venue.find_or_create_by_name_and_address(@name, @address)
    EventVenue.find_or_create_by_event_suggestion_id_and_venue_id(@event_suggestion.id, @venue.id)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @event_suggestion, notice: 'Venue added.' }
        format.json { render json: @venue }
      else
        format.html { redirect_to @event_suggestion, alert: 'Venue could not be added.' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end
end
