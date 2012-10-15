class BoolParameter < Parameter
  def default_metadata
    {
        'values' => %w(true false),
        'default' => 'false'
    }
  end
end
