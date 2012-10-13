class IntegerParameter < Parameter
  def values
    value.split(';').map(&:to_i)
  end
end
