require 'rails_helper'

RSpec.describe Room, type: :model do
  it "has a valid factory" do
    expect(build(:room)).to be_valid
  end

  it "is invalid without a male" do
    room = build(:room, male: nil)
    room.valid?
    expect(room.errors[:male]).to include("is not included in the list")
  end

  it "is invalid without a female" do
    room = build(:room, female: nil)
    room.valid?
    expect(room.errors[:female]).to include("is not included in the list")
  end
end
