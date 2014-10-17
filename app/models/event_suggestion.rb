class EventSuggestion < ActiveRecord::Base
  attr_accessible :name, :description, :location, :start_date, :end_date, :start_time, :status, :invitee_ids, :category

  belongs_to :host, class_name: 'User'
  has_many :invitations
  has_many :invitees, through: :invitations
  
  has_many :events, dependent: :destroy
  has_many :event_venues
  has_many :venues, through: :event_venues
  
  validates :start_date, presence: :true
  validates :category, presence: :true

  after_create :create_associated_events
  # before_save :check_event_has_location, if: :status_is_closed?
  # before_save :check_event_has_start_time, if: :status_is_closed?

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

  # def status_is_closed?
  #   status == "closed"
  # end

  # def check_event_has_location
  #   errors.add(:base, "Sorry, this event must have a location") unless location && location != ""
  # end
  # def check_event_has_start_time
  #   errors.add(:base, "Sorry, this event must have a start time") unless start_time
  # end

end
