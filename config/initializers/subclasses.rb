Event.select(:type).map(&:type).uniq
User.select(:type).map(&:type).uniq
Parameter.select(:type).map(&:type).uniq