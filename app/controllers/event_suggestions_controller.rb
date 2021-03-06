class EventSuggestionsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  def manage_events
    @events_as_host = (current_user.events_as_host).sort_by { |event| event.start_date }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events_as_host }
    end
  end

  def upcoming_events
    @events_as_host_closed = current_user.events_as_host.where(status: "closed")
    @events_as_invitee_closed = current_user.events_as_invitee.where(status: "closed")
    @event_choices = current_user.event_choices
    @events_responded_to_closed = (((@event_choices.collect { |choice| choice.event.event_suggestion }).uniq).collect { |event| event if event.status == "closed" }).compact
    @upcoming_events = ((@events_as_host_closed + @events_responded_to_closed).uniq).sort_by { |event| event.date }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @upcoming_events }
    end
  end

  def event_invitations
    @events_as_invitee = current_user.events_as_invitee
    @event_choices = current_user.event_choices
    @events_responded_to = (current_user.event_choices.collect { |choice| choice.event.event_suggestion }).uniq
    @events_pending = (@events_as_invitee - @events_responded_to).sort_by { |event| event.start_date }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events_pending }
    end
  end

  def accept_suggestions
    @event_suggestion = EventSuggestion.find(params[:id])

    chosen_event_ids = params[:event_ids] || []
    deselected_event_ids = @event_suggestion.event_ids - chosen_event_ids

    current_user.event_choices.where(event_id: deselected_event_ids).destroy_all

    chosen_event_ids.each do |event_id|
      EventChoice.find_or_create_by_user_id_and_event_id(current_user.id, event_id)
    end
    redirect_to @event_suggestion
  end

  # GET /event_suggestions/1
  # GET /event_suggestions/1.json
  def show
    @event_suggestion = EventSuggestion.find(params[:id])
    @invitees = @event_suggestion.invitees
    @event_venues = @event_suggestion.event_venues
    @events = @event_suggestion.events
    @current_user = current_user
    @event_choice = EventChoice.new
    @venue = Venue.new
    @event_venue = EventVenue.new
    @max_response_count = @events.map {|e| e.event_choices.length}.max
    @popular_events = @events.select{ |e| e.event_choices.length == @max_response_count }
    @chosen_event = @events.where(date: @event_suggestion.date).first
    @location = Venue.find(@event_suggestion.location) if @event_suggestion.location

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_suggestion }
    end
  end

  # GET /event_suggestions/new
  # GET /event_suggestions/new.json
  def new
    @event_suggestion = EventSuggestion.new
    @users_without_current_user = User.find(:all, :conditions => ["id != ?", current_user.id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_suggestion }
    end
  end

  # GET /event_suggestions/1/edit
  def edit
    @event_suggestion = EventSuggestion.find(params[:id])
    @users_without_current_user = User.find(:all, :conditions => ["id != ?", current_user.id])
    @time = @event_suggestion.start_time.strftime("%I:%M") if @event_suggestion.start_time
    @venues = @event_suggestion.venues
    @events_sorted = @event_suggestion.events.sort_by { |event| event.event_choices.length}
    @optimal_event_date = @events_sorted.last.date.strftime("%d/%m/%Y")
  end

  # POST /event_suggestions
  # POST /event_suggestions.json
  def create
    @event_suggestion = EventSuggestion.new(params[:event_suggestion])
    @event_suggestion.host = current_user
    @users_without_current_user = User.find(:all, :conditions => ["id != ?", current_user.id])

    respond_to do |format|
      if @event_suggestion.save
        format.html { redirect_to @event_suggestion, notice: 'Event suggestion was successfully created.' }
        format.json { render json: @event_suggestion, status: :created, location: @event_suggestion }
      else
        format.html { render action: "new" }
        format.json { render json: @event_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_suggestions/1
  # PUT /event_suggestions/1.json
  def update
    @event_suggestion = EventSuggestion.find(params[:id])
    if @event_suggestion.category == 'dinner'
      @event_suggestion.name = "Dinner with #{@event_suggestion.host.name || @event_suggestion.host.email}"
    else @event_suggestion.category == 'drinks'
      @event_suggestion.name = "Drinks with #{@event_suggestion.host.name || @event_suggestion.host.email}"
    end

    respond_to do |format|
      if @event_suggestion.update_attributes(params[:event_suggestion])
        format.html { redirect_to @event_suggestion, notice: 'Event suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def finalise
    @event_suggestion = EventSuggestion.find(params[:id])
    @time = @event_suggestion.start_time.strftime("%I:%M") if @event_suggestion.start_time
    @venues = @event_suggestion.venues
    @events_sorted = @event_suggestion.events.sort_by { |event| event.event_choices.length}
    @optimal_event_date = @events_sorted.last.date.strftime("%d/%m/%Y")

    respond_to do |format|
      format.html
      format.json { render json: @event_suggestion }
    end
  end

  def finalise_submit
    @event_suggestion = EventSuggestion.find(params[:id])
    @event_suggestion.status = "closed"

    respond_to do |format|
      if @event_suggestion.update_attributes(params[:event_suggestion])
        format.html { redirect_to @event_suggestion, notice: 'This event has now been finalised. Invitees can no longer RSVP to the event.' }
        format.json { head :no_content }
      else
        format.html { redirect_to finalise_event_suggestion_path(@event_suggestion), notice: 'Please make sure your event has a location, date and time.'}
        format.json { render json: @event_suggestion.errors, status: :unprocessable_entity, notice: 'Sorry this event could not be finalised. Please try again.' }
      end
    end
  end

  # DELETE /event_suggestions/1
  # DELETE /event_suggestions/1.json
  def destroy
    @event_suggestion = EventSuggestion.find(params[:id])
    @event_suggestion.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
