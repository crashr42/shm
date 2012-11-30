class SelectParameter < Parameter
  def default_metadata
    {
        :default => nil,
        :values => nil
    }
  end

  def metadata_validator
    {
        :default => {
            :_validate => lambda { |v| true },
            :_error_message => 'parameter.select.metadata.errors.default'
        },
        :values => {
            :_validate => lambda { |v| v.is_a? Array },
            :_error_message => 'parameter.select.metadata.errors.values'
        }
    }
  end

  def validate_value value
    metadata[:values].include? value.to_s
  end
end
