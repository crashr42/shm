class SelectParameter < Parameter
  def default_metadata
    {
        :default => nil,
        :values => []
    }
  end

  def metadata_validator
    {
        :default => {
            :_validate => lambda { |v| true },
            :_error_message => 'parameter.select.metadata.errors.default'
        },
        :values => {
            :_validate => lambda { |v| v.is_a? Array and v.length > 0 },
            :_error_message => 'parameter.select.metadata.errors.values'
        }
    }
  end

  def validate_value value
    metadata[:values].include? value.to_s
  end
end
