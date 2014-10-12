class EventSuggestion < ActiveRecord::Base
  attr_accessible :description, :end_date, :end_time, :location, :name, :start_date, :start_time, :status, :time_of_day

  belongs_to :host, class_name: 'User'
  has_many :invitations
  has_many :invitees, through: :invitations
  has_many :events
end
