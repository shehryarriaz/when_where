class CreateEventChoices < ActiveRecord::Migration
  def change
    create_table :event_choices do |t|
      t.references :event
      t.references :user

      t.timestamps
    end
    add_index :event_choices, :event_id
    add_index :event_choices, :user_id
  end
end
