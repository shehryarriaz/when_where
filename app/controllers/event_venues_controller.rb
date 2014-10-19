class EventVenuesController < ApplicationController

  def show
    @event_venue = EventVenue.find(params[:id])
    @event_suggestion = @event_venue.event_suggestion
    @venue = @event_venue.venue

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
    
    respond_to do |format|
      if @venue.save
        @event_venue = EventVenue.find_or_create_by_event_suggestion_id_and_venue_id(@event_suggestion.id, @venue.id)
        format.html { redirect_to @event_venue, notice: 'Venue added.' }
        format.json { render json: @venue }
      else
        format.html { redirect_to @event_suggestion, alert: 'Venue could not be added.' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @event_venue = EventVenue.find(params[:id])
    @venue = @event_venue.venue
    @venue_name = @venue.name
    @venue_address = @venue.address
  end

  def update
    @event_venue = EventVenue.find(params[:id])
    @event_suggestion = @event_venue.event_suggestion
    @name = params[:name]
    @address = params[:address]
    @description = params[:description]
    @venue = Venue.find_or_create_by_name_and_address(@name, @address)

    respond_to do |format|
      if @venue.save
        @event_venue.update_attributes(event_suggestion_id: @event_suggestion.id, venue_id: @venue.id, description: @description)
        format.html { redirect_to @event_venue, notice: 'Venue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def upvote
    @event_venue = EventVenue.find(params[:id])
    @event_suggestion = @event_venue.event_suggestion
    case params[:direction]
    when 'like'
      @event_venue.liked_by current_user
    when 'unlike'
      @event_venue.unliked_by current_user
    end

    respond_to do |format|
      if @event_venue.save
        raise
        format.html { redirect_to @event_suggestion, notice: 'You have successfully voted on #{@event_venue.venue.name}.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @event_suggestion, notice: 'Sorry, something went wrong. Please try voting again'}
        format.json { render json: @event_venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event_venue = EventVenue.find(params[:id])
    @event_suggestion = @event_venue.event_suggestion
    @event_venue.destroy

    respond_to do |format|
      format.html { redirect_to @event_suggestion }
      format.json { head :no_content }
    end
  end
end
