class BoolParameter < Parameter
  def default_metadata
    {
        :values => %w(true false),
        :default => 'false'
    }
  end

  def metadata_validator
    {
        :default => {
            :_validate => lambda { |v| default_metadata.values.include? v },
            :_error_message => 'parameter.bool.metadata.errors.default'
        },
        :values => {
            :_validate => lambda { |v| v == %w(true false) },
            :_error_message => 'parameter.bool.metadata.errors.values'
        }
    }
  end

  def validate_value value
    metadata[:values].include? value.to_s
  end
end
