class DiagnosticFactory
  def self.raw(patient_id, parameter_id, from, to)
    Parameter.find(parameter_id).type.gsub('Parameter', 'Diagnostic').constantize.raw(patient_id, parameter_id, from, to)
  end

  def self.chart(patient_id, parameter_id, from, to)
    Parameter.find(parameter_id).type.gsub('Parameter', 'Diagnostic').constantize.chart(patient_id, parameter_id, from, to)
  end
end