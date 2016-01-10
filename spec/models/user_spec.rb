# coding: utf-8

require 'rails_helper'

RSpec.describe User, type: :model do
  it "正しいデータの場合、validationエラーが発生しないこと" do
    expect(build(:user)).to be_valid
  end

  it "nameがない場合、validationエラーが発生すること" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("は2文字以上で入力してください")
  end

  it "nameが10文字以上の場合、validationエラーが発生すること" do
    user = build(:user, name: "longlongname")
    user.valid?
    expect(user.errors[:name]).to include("は10文字以内で入力してください")
  end

  it "genderがない場合、validationエラーが発生すること" do
    user = build(:user, gender: nil)
    user.valid?
    expect(user.errors[:gender]).to include("は一覧にありません")
  end

  it "statusがない場合、validationエラーが発生すること" do
    user = build(:user, status: nil)
    user.valid?
    expect(user.errors[:status]).to include("は一覧にありません")
  end

  it "statusが1~3以外の場合、validationエラーが発生すること" do
    user = build(:user, status: 5)
    user.valid?
    expect(user.errors[:status]).to include("は一覧にありません")
  end

  it "userが生成された時、roomが更新されること" do
    room = create(:room, :with_users)
    expect{ create(:user, room_id: room.id) }.to change{
      room.reload
      room.male
    }.from(1).to(2)
  end

end
