# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Tool.destroy_all
Category.destroy_all

5.times do
  User.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
end

5.times do
  Tool.create!(name: Faker::App.unique.name)
end

# Couldn't find a better alternative for category name...
3.times do
  Category.create!(name: Faker::Company.unique.industry)
end
