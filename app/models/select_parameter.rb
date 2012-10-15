class SelectParameter < Parameter
  def default_metadata
    {
        'default' => '',
        'values' => []
    }
  end
end
