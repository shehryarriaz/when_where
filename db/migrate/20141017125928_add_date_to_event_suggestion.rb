class AddDateToEventSuggestion < ActiveRecord::Migration
  def change
    add_column :event_suggestions, :date, :date
  end
end
