class EventSuggestion < ActiveRecord::Base
  attr_accessible :name, :description, :location, :start_date, :end_date, :start_time, :end_time, :time_of_day, :status

  belongs_to :host, class_name: 'User'
  has_many :invitations
  has_many :invitees, through: :invitations
  has_many :events

  validates :name, presence: :true
  validates :location, presence: :true
  validates :start_date, presence: :true

  after_create :create_associated_events

  private

  def create_associated_events
    if !end_date
      Event.create(date: start_date, event_suggestion_id: id)
    else
      (start_date..end_date).each do |date|
        Event.create(date: date, event_suggestion_id: id)
      end
    end
  end

end
