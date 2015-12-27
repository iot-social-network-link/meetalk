FactoryGirl.define do
  factory :user do
    association :room
    name 'name01'
    gender 'male'
  end
end
