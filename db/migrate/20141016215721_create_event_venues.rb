class CreateEventVenues < ActiveRecord::Migration
  def change
    create_table :event_venues do |t|
      t.references :event_suggestion
      t.references :venue

      t.timestamps
    end
    add_index :event_venues, :event_suggestion_id
    add_index :event_venues, :venue_id
  end
end
