class CreateHirings < ActiveRecord::Migration[8.0]
  def change
    create_table :hirings do |t|
      t.integer :hired_by_id
      t.string :service_request
      t.integer :tirador_id
      t.boolean :confirmed, default: false

      t.timestamps
    end
    add_index :hirings, :tirador_id
    add_index :hirings, :hired_by_id
  end
end
