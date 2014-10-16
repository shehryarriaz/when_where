class AddCategoryToEventSuggestion < ActiveRecord::Migration
  def change
    add_column :event_suggestions, :category, :string
  end
end
