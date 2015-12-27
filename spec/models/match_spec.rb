require 'rails_helper'

RSpec.describe Match, type: :model do
  it "is valid with a my_id, vote_id and room_id" do
    match = Match.new(
      my_id: 1,
      vote_id: 2,
      room_id: "g24jpFG"
    )
    expect(match).to be_valid
  end

  it "is invalid without a my_id" do
    match = Match.new(my_id: nil)
    match.valid?
    expect(match.errors[:my_id]).to include("can't be blank")
  end

  it "is invalid without a vote_id" do
    match = Match.new(vote_id: nil)
    match.valid?
    expect(match.errors[:vote_id]).to include("can't be blank")
  end

  it "is invalid without a room_id" do
    match = Match.new(room_id: nil)
    match.valid?
    expect(match.errors[:room_id]).to include("can't be blank")
  end
end
