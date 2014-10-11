# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_suggestion do
    name "MyString"
    description "MyText"
    location "MyString"
    status "MyString"
    host nil
    start_date "2014-10-11"
    end_date "2014-10-11"
    time_of_day "MyString"
    start_time "2014-10-11 18:22:41"
    end_time "2014-10-11 18:22:41"
  end
end
