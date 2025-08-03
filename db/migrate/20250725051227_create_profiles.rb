class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.date :birth_date
      t.string :sex
      t.string :province
      t.string :town
      t.string :barangay
      t.string :street
      t.string :service_1
      t.string :service_2
      t.string :service_3

      t.timestamps
    end
  end
end
