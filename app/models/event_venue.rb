class EventVenue < ActiveRecord::Base
  attr_accessible :event_suggestion_id, :venue_id

  belongs_to :event_suggestion
  belongs_to :venue
end
