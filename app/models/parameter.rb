class Parameter < ActiveRecord::Base
  attr_accessible :type, :name, :metadata
  attr_accessor :metadata
  before_save :merge_with_default_metadata

  def default_metadata
  end

  def metadata= value
    write_attribute(:metadata, default_metadata.merge(value).to_json)
  end

  def metadata
    return read_attribute(:metadata) ? default_metadata.merge(JSON.parse(read_attribute(:metadata)).to_hash) : default_metadata
  end

  private
  def merge_with_default_metadata
    write_attribute(:metadata, default_metadata.merge(read_attribute(:metadata) ? JSON.parse(read_attribute(:metadata)).to_hash : {}).to_json)
  end
end
