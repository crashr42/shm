class StringParameter < Parameter
  def default_metadata
    {
        :default => ''
    }
  end

  def metadata_validator
    {
        :default => {
            :_validate => lambda { |v| true },
            :_error_message => 'parameter.string.metadata.errors.default'
        }
    }
  end

  def validate_value value ; true end
end
