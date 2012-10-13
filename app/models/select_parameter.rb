class SelectParameter < Parameter
  def values
    value.split(';')
  end
end
