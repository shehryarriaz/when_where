class Event < ActiveRecord::Base
  attr_accessible :date, :event_suggestion_id

  belongs_to :event_suggestion
end

public
def day_name
  self.date.strftime("%A")
end