# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :edge do
    relationship "MyString"
  end
end
