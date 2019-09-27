# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

100.times do
  Sample.create(
    patient_id: Faker::Number.number(digits: 1),
    amount: Faker::Number.decimal(l_digits: 4, r_digits: 2),
    month: Faker::Number.number(digits: 1)
  )
end