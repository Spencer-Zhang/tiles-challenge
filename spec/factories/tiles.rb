# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tile do
    sequence(:name) { |n| n }
  end
end
