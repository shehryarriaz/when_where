class EventChoicesController < ApplicationController

  before_filter :authenticate_user!

  # GET /event_suggestions/new
  # GET /event_suggestions/new.json
  def new
    @event_choice = EventChoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_choice }
    end
  end

  def create
    @event_choice = EventChoice.new(params[:event_choice])
    @event_choice.host = current_user

    respond_to do |format|
      if @event_choice.save
        format.html { redirect_to @event_choice, notice: 'Event choice was successfully created.' }
        format.json { render json: @event_choice, status: :created, location: @event_choice }
      else
        format.html { render action: "new" }
        format.json { render json: @event_choice.errors, status: :unprocessable_entity }
      end
    end
  end
end