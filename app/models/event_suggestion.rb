class EventSuggestion < ActiveRecord::Base
  attr_accessible :name, :description, :location, :start_date, :end_date, :start_time, :invitee_ids, :category, :date

  belongs_to :host, class_name: 'User'
  has_many :invitations
  has_many :invitees, through: :invitations
  
  has_many :events, dependent: :destroy
  has_many :event_venues
  has_many :venues, through: :event_venues
  
  validates :start_date, presence: {message: "You need to select at least a start date."}
  validates :category, presence: {message: "You need to choose either dinner or drinks!"}

  after_create :create_associated_events
  validate :check_end_date_is_later_than_start_date
  validate :check_event_has_location_if_finalised
  validate :check_event_has_start_time_if_finalised
  validate :check_event_has_date_if_finalised

  private
  def check_end_date_is_later_than_start_date
    if end_date
      errors.add(:base, "End date can't be earlier than the start date! That just doesn't make sense... ") unless end_date >= start_date
    end
  end

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

  private
  def check_event_has_location_if_finalised
    if status == 'closed'
      errors.add(:base, "Sorry, this event must have a location") unless location.present?
    end
  end

  private
  def check_event_has_start_time_if_finalised
    if status == 'closed'
      errors.add(:base, "Sorry, this event must have a start time") unless start_time
    end
  end

  private
  def check_event_has_date_if_finalised
    if status == 'closed'
      errors.add(:base, "Sorry, this event must have a date") unless date
    end
  end

end
