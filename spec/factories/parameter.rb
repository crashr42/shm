FactoryGirl.define do
  %w(parameter bool_parameter integer_parameter select_parameter string_parameter).each do |p|
    factory p.to_sym do
      name 'test parameter'
      rule_parameter_input { create(:rule_parameter_input) }
      type p.classify
    end
  end
end