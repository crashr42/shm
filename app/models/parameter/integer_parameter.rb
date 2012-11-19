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
end
