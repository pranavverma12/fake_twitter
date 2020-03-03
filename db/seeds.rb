# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all

(0..35).each do |i|
  name = Faker::FunnyName.name

  user = User.new(username: "#{Faker::Internet.username(specifier: name, separators: %w[])}#{i}",
                  password: 'securePassword',
                  email: Faker::Internet.safe_email(name: name))

  next if user.save

  puts 'Failed to build a seed User:'
  pp user.errors.full_messages
  pp user
  exit 0
end
