class EventChoice < ActiveRecord::Base
  attr_accessible :event_id, :user_id

  belongs_to :event
  belongs_to :user

  validate :check_event_suggestion_is_open

  private
  def check_event_suggestion_is_open
    errors.add(:base, "Sorry, this event has already been finalised. You can no longer change your response") unless event.event_suggestion.status == 'open'
  end
end
