class StringParameter < Parameter
  def default_metadata
    {
        'default' => ''
    }
  end

  def metadata_validator
    {
        'default' => {
            '@validate' => lambda {|v| true},
            '@error_message' => 'parameter.string.metadata.errors.default'
        }
    }
  end
end
