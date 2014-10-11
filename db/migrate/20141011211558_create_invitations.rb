class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :event_suggestion
      t.references :invitee

      t.timestamps
    end
    add_index :invitations, :event_suggestion_id
    add_index :invitations, :invitee_id
  end
end
