FactoryGirl.define do
  factory :parameter do
    name 'test parameter'
    rule_parameter_input_id 1
  end

  factory :bool_parameter do
    name 'test parameter'
    rule_parameter_input_id 1
  end

  factory :integer_parameter do
    name 'test parameter'
    rule_parameter_input_id 1
  end

  factory :select_parameter do
    name 'test parameter'
    rule_parameter_input_id 1
  end
end