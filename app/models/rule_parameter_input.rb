class RuleParameterInput < ActiveRecord::Base
  # Параметры с которыми связано правило
  has_many :parameters

  attr_accessible :rule
end
