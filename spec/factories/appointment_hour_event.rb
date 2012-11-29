FactoryGirl.define do
  factory :appointment_event do
    date_start  DateTime.now.at_beginning_of_hour
    date_end    DateTime.now.at_beginning_of_hour + 2.hours
    description 'some description'

    Event.statuses.each do |s|
      factory "appointment_#{s}_event".to_sym do
        status s
      end
    end

    summary 'some summary'
  end
end