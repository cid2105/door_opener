class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.boolean :active, :default => :false
      t.integer :minute
      t.integer :hour
      t.string :key, :null => :false

      t.timestamps
    end
  end
end
