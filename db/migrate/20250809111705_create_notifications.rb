class CreateNotifications < ActiveRecord::Migration[8.0]
  def up
    create_table :notifications do |t|
      t.integer :tirador_id
      t.integer :hired_by_id
      t.string :title
      t.text :message
      t.boolean :read, default: false

      t.timestamps
    end
    add_index :notifications, :tirador_id
    add_index :notifications, :hired_by_id
  end

  def down
    drop_table :notifications
  end
end
