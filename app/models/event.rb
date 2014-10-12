class Event < ActiveRecord::Base
  attr_accessible :date, :event_suggestion_id

  belongs_to :event_suggestion
  has_many :event_choices
  has_many :users, through: :event_choices
end

public
def day_name
  self.date.strftime("%A")
end