class Venue < ActiveRecord::Base
  attr_accessible :address, :name, :latitude, :longitude

  has_many :event_venues
  has_many :event_suggestions, through: :event_venues

  geocoded_by :address
  after_validation :geocode

  validates :name, presence: :true
  validates :address, presence: :true
end