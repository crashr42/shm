FactoryGirl.define do
  factory :parameters_data do
    parameter { create(:string_parameter) }
    patient_user { create(:patient_user) }
    value 'test'
  end
end