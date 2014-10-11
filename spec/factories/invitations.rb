# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    event_suggestion nil
    invitee nil
  end
end
