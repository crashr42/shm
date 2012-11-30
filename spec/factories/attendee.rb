FactoryGirl.define do
  factory :attendee do
    user { create(:user) }
    event { create(:event) }
    type 'Attendee'
  end
end