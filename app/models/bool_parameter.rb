class BoolParameter < Parameter
  def default_metadata
    {
        'values' => %w(true false),
        'default' => 'false'
    }
  end

  def metadata_validator
    {
        'default' => {
            '@validate' => lambda {|v| v == 'true' || v == 'false'},
            '@error_message' => 'parameter.bool.metadata.errors.default'
        },
        'values' => {
            '@validate' => lambda {|v| v.is_a?(Array) && v.size == 2 && v.include?('true') && v.include?('false')},
            '@error_message' => 'parameter.bool.metadata.errors.values'
        }
    }
  end
end
