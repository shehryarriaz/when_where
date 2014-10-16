class RemoveTimeOfDayAndEndTimeFromEventSuggestion < ActiveRecord::Migration
  def up
    remove_column :event_suggestions, :time_of_day
    remove_column :event_suggestions, :end_time
  end

  def down
    add_column :event_suggestions, :end_time, :time
    add_column :event_suggestions, :time_of_day, :string
  end
end
