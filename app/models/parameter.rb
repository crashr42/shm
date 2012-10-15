class Parameter < ActiveRecord::Base
  attr_accessible :type, :name, :metadata
  attr_accessor :metadata

  def default_metadata
  end

  def metadata= value
    write_attribute(:metadata, default_metadata.merge(value).to_json)
  end

  def metadata
    return read_attribute(:metadata) ? default_metadata.merge(JSON.parse(read_attribute(:metadata)).to_hash) : default_metadata
  end
end
