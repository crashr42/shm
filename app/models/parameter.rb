class Parameter < ActiveRecord::Base
  has_many :parameters_to_patientses, :class_name => ParametersToPatients
  # Пациенты которым назначен данный параметр
  has_many :patient_users, :through => :parameters_to_patientses, :foreign_key => :user_id
  # Введенные значения для параметра
  has_many :parameters_datas
  # Правило ввода параметра
  belongs_to :rule_parameter_input

  attr_accessible :type, :name, :metadata, :rule_parameter_input, :rule_parameter_input_id
  attr_accessor :metadata
  before_save :merge_with_default_metadata
  validate :validate_metadata_structure
  validates_presence_of :name
  validates_presence_of :rule_parameter_input_id

  # Метаданные параметра по-умолчанию
  def default_metadata ; {} end
  # Метод для валидации структуры метаданных
  def metadata_validator ; {} end
  # Метод для валидации значения параметра
  def validate_value ; false end

  def metadata= value
    write_attribute(:metadata, default_metadata.merge(value).to_json)
  end

  def metadata
    return read_attribute(:metadata) ?
        default_metadata.merge(JSON.parse(read_attribute(:metadata), {:symbolize_names => true}).to_hash) : default_metadata
  end

  private

  # Слияние дефолтных метаданных с указанными
  def merge_with_default_metadata
    write_attribute(:metadata, default_metadata.merge(
        read_attribute(:metadata) ?
            JSON.parse(read_attribute(:metadata), {:symbolize_names => true}).to_hash : {}).to_json)
  end

  # Проверка структуру метаданных
  def validate_metadata_structure
    validate_hashes metadata_validator, metadata
  end

  # Валидация структуры хэш-таблицы на основе другой хэш-таблицы
  def validate_hashes validator_hash, validated_hash
    validated_hash.each do |k, v|
      if k[0] != '_'
        if validator_hash.include?(k)
          validator = validator_hash[k]
          errors.add(:metadata, validator[:_error_message]) unless validator[:_validate].call(v)
          validate_hashes validator_hash[k], v if v.is_a? Hash
        else
          errors.add(:metadata, 'parameter.errors.metadata.not_defined_key')
        end
      else
        errors.add(:metadata, 'parameter.errors.metadata.invalid_key')
      end
    end
  end
end
