class ParametersData < ActiveRecord::Base
  # Пациент который ввел значение параметра
  belongs_to :patient_user, :foreign_key => :user_id
  # Параметр, чье значение ввел пациент
  belongs_to :parameter

  validates :value, :presence => true
  validates :user_id, :presence => true
  validates :parameter_id, :presence => true
  validate :valid_for_parameter_metadata

  attr_accessible :parameter, :parameter_id, :patient_user, :user_id, :value

  def self.diagnostic(patient_id, parameter_id, from, to)
    self.where({
        :user_id      => patient_id,
        :parameter_id => parameter_id
    }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at).map { |p|
      [p.created_at.to_i * 1000, p.value.to_i]
    }
  end

  private

  # Валидация введенного значения параметра
  def valid_for_parameter_metadata
    errors.add(:value, 'parameter.data.invalid.value') unless self.parameter.validate_value(self.value)
  end
end
