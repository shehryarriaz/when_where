class Event < ActiveRecord::Base
  attr_accessible :date

  belongs_to :event_suggestion
end
