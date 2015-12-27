require 'rails_helper'

RSpec.describe Room, type: :model do
  it "is valid with a male and female" do
    room = Room.new(male: 1, female: 2)
    expect(room).to be_valid
  end

  it "is invalid without a male" do
    room = Room.new(male: nil)
    room.valid?
    expect(room.errors[:male]).to include("is not included in the list")
  end

  it "is invalid without a female" do
    room = Room.new(female: nil)
    room.valid?
    expect(room.errors[:female]).to include("is not included in the list")
  end
end
