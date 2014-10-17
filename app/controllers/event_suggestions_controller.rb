class EventSuggestionsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /event_suggestions
  # GET /event_suggestions.json
  def index
    @events = EventSuggestion.all

    @events_as_host = current_user.events_as_host
    @events_as_invitee = current_user.events_as_invitee
    @event_choices = current_user.event_choices
    @events_responded_to = (current_user.event_choices.collect { |choice| choice.event.event_suggestion }).uniq
    @events_pending = @events_as_invitee - @events_responded_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_suggestions }
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
    @venues = @event_suggestion.venues
    @events = @event_suggestion.events
    @optimal_event = @events.max_by { |e| e.event_choices.length }
    @current_user = current_user
    @event_choice = EventChoice.new
    @event_venue = EventVenue.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_suggestion }
    end
  end

  # GET /event_suggestions/new
  # GET /event_suggestions/new.json
  def new
    @event_suggestion = EventSuggestion.new
    @events_without_current_user = User.find(:all, :conditions => ["id != ?", current_user.id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_suggestion }
    end
  end

  # GET /event_suggestions/1/edit
  def edit
    @event_suggestion = EventSuggestion.find(params[:id])
    @events_without_current_user = User.find(:all, :conditions => ["id != ?", current_user.id])
  end

  # POST /event_suggestions
  # POST /event_suggestions.json
  def create
    @event_suggestion = EventSuggestion.new(params[:event_suggestion])
    @event_suggestion.host = current_user
    if @event_suggestion.category == 'dinner'
      @event_suggestion.name = "Dinner with #{@event_suggestion.host.name || @event_suggestion.host.email}"
    else @event_suggestion.category == 'drinks'
      @event_suggestion.name = "Drinks with #{@event_suggestion.host.name || @event_suggestion.host.email}"
    end

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

  # DELETE /event_suggestions/1
  # DELETE /event_suggestions/1.json
  def destroy
    @event_suggestion = EventSuggestion.find(params[:id])
    @event_suggestion.destroy

    respond_to do |format|
      format.html { redirect_to event_suggestions_url }
      format.json { head :no_content }
    end
  end
end
