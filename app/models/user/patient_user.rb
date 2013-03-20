class PatientUser < User
  # Лечащий врач для пациента
  belongs_to :doctor_user
  # Списое диагнозов для пациента
  has_many :patient_to_diagnosess, :foreign_key => :user_id
  has_many :diagnosis, :through => :patient_to_diagnosess
  # Список параметров для пациента
  has_many :parameters_to_patientses, :class_name => ParametersToPatients, :foreign_key => :user_id
  has_many :parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :bool_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :integer_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :select_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :string_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  # Данные по параметрам
  has_many :parameters_datas
  # События-приемы в которых участвовал пациент
  has_many :patient_attendees, :foreign_key => :user_id
  has_many :appointment_events, :through => :patient_attendees, :foreign_key => :user_id

  has_many :patient_to_medicamentss, :foreign_key => :users_id
  has_many :medicaments, :through => :patient_to_medicamentss

  default_scope :joins => :roles
  default_scope where("roles.name = 'patient'")
  default_scope :readonly => false
end
