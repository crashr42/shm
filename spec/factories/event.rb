FactoryGirl.define do
  factory :event, :class => Event do
    date_start  DateTime.now
    date_end    DateTime.now + 15.minutes
    description 'some description'

    factory :free_event do
      status 'free'
    end

    factory :busy_event do
      status 'busy'
    end

    factory :process_event do
      status 'process'
    end

    factory :close_event do
      status 'close'
    end

    summary 'some summary'
    type    'Event'
  end
end