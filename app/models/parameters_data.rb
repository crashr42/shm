class ParametersData < ActiveRecord::Base
  # Пациент который ввел значение параметра
  belongs_to :patient_user, :foreign_key => :user_id
  # Параметр, чье значение ввел пациент
  belongs_to :parameter

  after_commit :publish, :on => :create

  validates :value, :presence => true
  validates :user_id, :presence => true
  validates :parameter_id, :presence => true
  validate :valid_for_parameter_metadata

  attr_accessible :parameter, :parameter_id, :patient_user, :user_id, :value

  private
  # Валидация введенного значения параметра
  def valid_for_parameter_metadata
    errors.add(:value, 'parameter.data.invalid.value') unless self.parameter.validate_value(self.value)
  end

  def publish
    # Сообщаем что пациент заполнил параметр
    patient_user.push({:user => patient_user, :parameter => parameter, :data => self}, 'parameter_data.create')
  end
end
