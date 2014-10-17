class Venue < ActiveRecord::Base
  attr_accessible :address, :name

  has_many :event_venues
  has_many :event_suggestions, through: :event_venues

  validates :name, presence: :true
  validates :address, presence: :true
end