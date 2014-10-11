class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :role, default: 'basic_user'

      t.timestamps
    end
  end
end
