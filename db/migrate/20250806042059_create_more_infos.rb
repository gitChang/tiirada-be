class CreateMoreInfos < ActiveRecord::Migration[8.0]
  def change
    create_table :more_infos do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :active_service
      t.boolean :is_verified, default: false
      t.float :average_rating, default: 0.0
      t.boolean :is_hired, default: false

      t.timestamps
    end
  end
end
