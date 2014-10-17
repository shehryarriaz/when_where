class EventSuggestion < ActiveRecord::Base
  attr_accessible :name, :description, :location, :start_date, :end_date, :start_time, :invitee_ids, :category

  belongs_to :host, class_name: 'User'
  has_many :invitations
  has_many :invitees, through: :invitations
  has_many :events, dependent: :destroy

  
  validates :start_date, presence: :true
  validates :category, presence: :true

  after_create :create_associated_events
  validate :check_event_has_location_if_finalised
  validate :check_event_has_start_time_if_finalised

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

end
