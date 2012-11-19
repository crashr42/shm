class Parameter < ActiveRecord::Base
  has_many :parameters_to_patientses, :class_name => ParametersToPatients
  has_many :patient_users, :through => :parameters_to_patientses, :foreign_key => :user_id
  has_many :parameters_datas

  attr_accessible :type, :name, :metadata
  attr_accessor :metadata
  before_save :merge_with_default_metadata
  validate :validate_metadata_structure
  validates_presence_of :name

  def default_metadata ; {} end
  def metadata_validator ; {} end

  def metadata= value
    write_attribute(:metadata, default_metadata.merge(value).to_json)
  end

  def metadata
    return read_attribute(:metadata) ?
        default_metadata.merge(JSON.parse(read_attribute(:metadata), {:symbolize_names => true}).to_hash) : default_metadata
  end

  private
  def merge_with_default_metadata
    write_attribute(:metadata, default_metadata.merge(
        read_attribute(:metadata) ?
            JSON.parse(read_attribute(:metadata), {:symbolize_names => true}).to_hash : {}).to_json)
  end

  def validate_metadata_structure
    validate_hashes metadata_validator, metadata
  end

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
