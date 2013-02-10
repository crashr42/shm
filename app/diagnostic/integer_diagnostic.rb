class IntegerDiagnostic
  def self.chart(patient_id, parameter_id, from, to)
    ParametersData.where({
        :user_id => patient_id,
        :parameter_id => parameter_id
    }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at).map { |p|
      [p.created_at.to_i * 1000, p.value.to_i]
    }
  end

  def self.raw(patient_id, parameter_id, from, to)
    ParametersData.where({
        :user_id => patient_id,
        :parameter_id => parameter_id
    }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at)
  end
end