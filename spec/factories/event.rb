FactoryGirl.define do
  factory :event, :class => Event do
    date_start  DateTime.now
    date_end    DateTime.now + 15.minutes
    description 'some description'

    Event.statuses.each do |s|
      factory "#{s}_event".to_sym do
        status s
      end
    end

    summary 'some summary'
    type    'Event'
  end
end