class SelectParameter < Parameter
  def default_metadata
    {
        'default' => '',
        'values' => []
    }
  end

  def metadata_validator
    {
        'default' => {
            '@validate' => lambda {|v| true},
            '@error_message' => 'parameter.select.metadata.errors.default'
        },
        'values' => {
            '@validate' => lambda {|v| v.is_a? Array},
            '@error_message' => 'parameter.select.metadata.errors.values'
        }
    }
  end
end
