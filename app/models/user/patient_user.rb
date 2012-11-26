class PatientUser < User
  belongs_to :doctor_user
  belongs_to :diagnosis
  has_many :parameters_to_patientses, :class_name => ParametersToPatients, :foreign_key => :user_id
  has_many :parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :bool_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :integer_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :select_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :string_parameters, :through => :parameters_to_patientses, :foreign_key => :parameter_id
  has_many :parameters_datas

  default_scope :joins => :roles
  default_scope where("roles.name = 'patient'")
  default_scope :readonly => false
end
