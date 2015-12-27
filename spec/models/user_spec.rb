require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("is too short (minimum is 2 characters)")
  end

  it "is invalid with a long name" do
    user = build(:user, name: "longlongname")
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 10 characters)")
  end

  it "is invalid without a gender" do
    user = build(:user, gender: nil)
    user.valid?
    expect(user.errors[:gender]).to include("is not included in the list")
  end

end
