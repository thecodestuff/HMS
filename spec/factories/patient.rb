require 'faker'

FactoryBot.define do
  factory :patient do
    user_id               { 50 }
    patient_type          { 'out_patient' }
    admit_date            { Date.current }
    dischagre_on          { nil }
    status                { 'not_admit' }
    ward_occupancy_detail_id { nil }
  end

  factory :valid_patient, class: Patient do
    patient_type          { 'out_patient' }
    admit_date            { Date.current }
    dischagre_on          { nil }
    status                { 'not_admit' }
    ward_occupancy_detail_id { nil }
  end
end
