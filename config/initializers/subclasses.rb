[:event, :user, :parameter].each do |c|
  if ActiveRecord::Base.connection.tables.include?(c.to_s.pluralize) and !defined?(::Rake)
    c.to_s.classify.constantize.select(:type).map(&:type).uniq
  end
end