class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :event_suggestion
      t.date :date

      t.timestamps
    end
    add_index :events, :event_suggestion_id
  end
end
