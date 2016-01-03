FactoryGirl.define do
  factory :room do
    male 1
    female 0

    factory :full_room do
      male 2
      female 2
    end

    trait :with_users do
      after(:build) do |room|
        unless room.male.nil?
          room.male.times { room.users << FactoryGirl.build(:user, room: room, gender: 'male') }
        end
        unless room.female.nil?
          room.female.times { room.users << FactoryGirl.build(:user, room: room, gender: 'female') }
        end
      end
    end
  end
end
