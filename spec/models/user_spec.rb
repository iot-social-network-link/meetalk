require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, gender and room_id" do
    room = Room.create(male: 1, female: 2)
    user = room.user.new(name: 'hayashi', gender: 'male')
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("is too short (minimum is 2 characters)")
  end

  it "is invalid with a long name" do
    user = User.new(name: "longlongname")
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 10 characters)")
  end

  it "is invalid without a gender" do
    user = User.new(gender: nil)
    user.valid?
    expect(user.errors[:gender]).to include("is not included in the list")
  end

  it "is invalid without a room_id" do
    user = User.new(room_id: nil)
    user.valid?
    expect(user.errors[:room_id]).to include("can't be blank")
  end
end
