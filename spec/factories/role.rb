FactoryGirl.define do
  %w(patient doctor admin manager).each do |r|
    factory "#{r}_role".to_sym, :class => Role do
      name r
    end
  end
end