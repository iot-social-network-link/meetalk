FactoryGirl.define do
  factory :room do
    male 1
    female 0

    after(:build) do |room|
      n = 0
      n += room.male unless room.male.nil?
      n += room.female unless room.female.nil?
      n.times { room.users << FactoryGirl.build(:user, room: room) }
    end

    factory :full_room do
      male 2
      female 2
    end
  end
end
