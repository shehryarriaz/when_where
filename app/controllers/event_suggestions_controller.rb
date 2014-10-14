class EventSuggestionsController < ApplicationController

  before_filter :authenticate_user!

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

  # GET /event_suggestions/1
  # GET /event_suggestions/1.json
  def show
    @event_suggestion = EventSuggestion.find(params[:id])
    @invitees = @event_suggestion.invitees
    @events = @event_suggestion.events

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_suggestion }
    end
  end

  # GET /event_suggestions/new
  # GET /event_suggestions/new.json
  def new
    @event_suggestion = EventSuggestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_suggestion }
    end
  end

  # GET /event_suggestions/1/edit
  def edit
    @event_suggestion = EventSuggestion.find(params[:id])
  end

  # POST /event_suggestions
  # POST /event_suggestions.json
  def create
    @event_suggestion = EventSuggestion.new(params[:event_suggestion])
    @event_suggestion.host = current_user

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
