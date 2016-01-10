# coding: utf-8

require 'rails_helper'

RSpec.describe Match, type: :model do
  it "正しいデータの場合、validationエラーが発生しないこと" do
    expect(build(:match)).to be_valid
  end

  it "user_idがない場合、validationエラーが発生すること" do
    match = build(:match, user_id: nil)
    match.valid?
    expect(match.errors[:user_id]).to include("を入力してください")
  end

  it "vote_idがない場合、validationエラーが発生すること" do
    match = build(:match, vote_id: nil)
    match.valid?
    expect(match.errors[:vote_id]).to include("を入力してください")
  end

  it "room_idが自動生成されること" do
    expect(create(:match).room_id).to be_truthy
  end

  it "room_idは32文字であること" do
    expect(create(:match).room_id.size).to eq 32
  end

  it "room_idはランダム英数字であること" do
    expect(create(:match).room_id).to match /\w+/
  end

end
