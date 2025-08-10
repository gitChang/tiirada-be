class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :profile, null: false, foreign_key: true
      t.integer :rating
      t.text :comment
      t.string :reviewer_name

      t.timestamps
    end
  end
end
