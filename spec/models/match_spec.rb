require 'rails_helper'

RSpec.describe Match, type: :model do
  it "has a valid factory" do
    expect(build(:match)).to be_valid
  end

  it "is invalid without a my_id" do
    match = build(:match, my_id: nil)
    match.valid?
    expect(match.errors[:my_id]).to include("can't be blank")
  end

  it "is invalid without a vote_id" do
    match = build(:match, vote_id: nil)
    match.valid?
    expect(match.errors[:vote_id]).to include("can't be blank")
  end

  it "is invalid without a room_id" do
    match = build(:match, room_id: nil)
    match.valid?
    expect(match.errors[:room_id]).to include("can't be blank")
  end
end
