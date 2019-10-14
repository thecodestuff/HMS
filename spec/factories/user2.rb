require 'faker'

FactoryBot.define do
  factory :valid_user, class: User do
    email       { Faker::Internet.email }
    firstname   { Faker::Name.first_name.downcase }
    lastname    { Faker::Name.last_name.downcase }
    password    { Faker::Internet.password(min_length: 6, max_length: 10) }
    civil_id    { Faker::Number.number(digits: 10) }
    department  { Faker::Lorem.words }
    phone       { Faker::PhoneNumber.phone_number }
    blood_group { 'O+' }
    age         { Faker::Number.between(from: 1, to: 100) }
    house_no    { Faker::Number.between(from:100, to: 500) }
    street      { Faker::Address.street_name  }
    locality    { Faker::Address.street_name  }
    city        { Faker::Address.city }
    state       { Faker::Address.state }
    pincode     { Faker::Address.zip_code }
    country     { Faker::Address.country }
    admin       { false }
    role        { 'Physician' }
  end

  factory :invalid_user, class: User do
    email       { Faker::Internet.email }
    #firstname   { Faker::Name.first_name.downcase }
    lastname    { Faker::Name.last_name.downcase }
    password    { Faker::Internet.password(min_length: 2, max_length: 5) }
    civil_id    { Faker::Number.number(digits: 10) }
    department  { Faker::Lorem.words }
    phone       { Faker::PhoneNumber.phone_number }
    blood_group { 'O+' }
    age         { Faker::Number.between(from: 100, to: 120) }
    house_no    { Faker::Number.between(from:100, to: 500) }
    street      { Faker::Address.street_name  }
    locality    { Faker::Address.street_name  }
    city        { Faker::Address.city }
    state       { Faker::Address.state }
    pincode     { Faker::Address.zip_code }
    country     { Faker::Address.country }
    admin       { false }
    role        { 'Physician' }
  end
end
