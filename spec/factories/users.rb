FactoryGirl.define do
  factory :user do
    association :room
    name 'name01'
    gender 'male'
    status 1
  end
end
