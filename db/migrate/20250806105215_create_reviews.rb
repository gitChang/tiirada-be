class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.integer :tirador_id # when a client made a review
      t.integer :client_id # when a tirador made a review
      t.integer :rating
      t.text :comment

      t.timestamps
    end

    add_index :reviews, :tirador_id
    add_index :reviews, :client_id
  end
end
