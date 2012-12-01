class IntegerParameter < Parameter
  def default_metadata
    {
        :default => nil,
        :validators => {
            :min => nil,
            :max => nil
        }
    }
  end

  def metadata_validator
    {
        :default => {
            :_validate => lambda { |v| Integer(v) rescue false },
            :_error_message => 'parameter.integer.metadata.errors.default'
        },
        :validators => {
            :_validate => lambda { |v| v.is_a? Hash },
            :_error_message => 'parameter.integer.metadata.errors.validators',
            :min => {
                :_validate => lambda { |v| Integer(v) rescue false },
                :_error_message => 'parameter.integer.metadata.errors.validators.min'
            },
            :max => {
                :_validate => lambda { |v| Integer(v) rescue false },
                :_error_message => 'parameter.integer.metadata.errors.validators.max'
            }
        }
    }
  end

  def validate_value value
    if (value.to_s =~ /^[-+]?[0-9]+$/).nil?
      false
    else
      value.to_i.between? metadata[:validators][:min].to_i, metadata[:validators][:max].to_i
    end
  end
end
