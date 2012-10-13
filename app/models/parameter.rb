class Parameter < ActiveRecord::Base
  attr_accessible :name, :default, :value

  def values
    value
  end
end
