class ChartFactory
  def self.build(patient_id, parameter_id, from, to)
    parameter = Parameter.find(parameter_id)
    parameter.type.gsub('Parameter', 'Chart').constantize.build(patient_id, parameter_id, from, to)
  end
end