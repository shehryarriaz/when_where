class CreateEventSuggestions < ActiveRecord::Migration
  def change
    create_table :event_suggestions do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :status, default: 'open'
      t.references :host
      t.date :start_date
      t.date :end_date
      t.string :time_of_day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
    add_index :event_suggestions, :host_id
  end
end
