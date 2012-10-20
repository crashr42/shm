class IntegerParameter < Parameter
  def default_metadata
    {
        'default' => nil,
        'validators' => {
            'min' => nil,
            'max' => nil
        }
    }
  end

  def metadata_validator
    {
        'default' => {
            '@validate' => lambda {|v| Integer(v) rescue false},
            '@error_message' => 'parameter.integer.metadata.errors.default'
        },
        'validators' => {
            '@validate' => lambda {|v| v.is_a? Hash},
            '@error_message' => 'parameter.integer.metadata.errors.validators',
            'min' => {
                '@validate' => lambda {|v| Integer(v) rescue false},
                '@error_message' => 'parameter.integer.metadata.errors.validators.min'
            },
            'max' => {
                '@validate' => lambda {|v| Integer(v) rescue false},
                '@error_message' => 'parameter.integer.metadata.errors.validators.max'
            }
        }
    }
  end
end
