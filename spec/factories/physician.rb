require 'faker'

FactoryBot.define do
  factory :physician do
    charge            { 100 }
    charge_at_weekend { 170.00 }
  end
end
