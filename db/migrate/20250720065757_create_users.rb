class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :mobile_number
      t.string :email_address, index: { unique: true }
      t.string :username
      t.string :password_digest
      t.string :api_token, index: { unique: true }

      t.timestamps
    end
  end
end
