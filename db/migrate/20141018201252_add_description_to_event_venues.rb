class AddDescriptionToEventVenues < ActiveRecord::Migration
  def change
    add_column :event_venues, :description, :text
  end
end
