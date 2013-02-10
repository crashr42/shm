class SelectDiagnostic
  def self.chart(patient_id, parameter_id, from, to)
    values = Hash.new { |h, k| h[k] = 0 }
    ParametersData.where({
        :user_id => patient_id,
        :parameter_id => parameter_id
    }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at).map { |p|
      values[p.value] += 1
    }
    values.map { |k, v| [k, v] }
  end

  def self.raw(patient_id, parameter_id, from, to)
    ParametersData.where({
        :user_id => patient_id,
        :parameter_id => parameter_id
    }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at)
  end
end