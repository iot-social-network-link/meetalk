FactoryGirl.define do
  factory :room do
    male 2
    female 1

    after(:build) do |room|
      3.times { room.users << FactoryGirl.build(:user, room: room) }
    end
  end
end
