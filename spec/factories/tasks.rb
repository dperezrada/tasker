# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
  	questions		[FactoryGirl.build(:question)]
  end
end
