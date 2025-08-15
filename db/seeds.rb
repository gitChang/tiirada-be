# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  mobile_number: '09678560204',
  email_address: 'charliepandacan@gmail.com',
  username: 'chang',
  password: '111111',
  password_confirmation: '111111'
)
puts "\n\t => User: chang, created."

User.create!(
  mobile_number: '09264284642',
  email_address: 'lulu.junejane15@gmail.com',
  username: 'junejane',
  password: '222222',
  password_confirmation: '222222'
)
puts "\n\t => User: junejane, created."

