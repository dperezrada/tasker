# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email)		{ |n| "test_#{n}@example.com"}
  	password				"password"
  end
end
