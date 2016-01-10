# coding: utf-8

require 'rails_helper'

RSpec.describe Room, type: :model do
  it "正しいデータの場合、validationエラーが発生しないこと" do
    expect(build(:room)).to be_valid
  end

  it "maleがない場合、validationエラーが発生すること" do
    room = build(:room, male: nil)
    room.valid?
    expect(room.errors[:male]).to include("は一覧にありません")
  end

  it "femaleがない場合、validationエラーが発生すること" do
    room = build(:room, female: nil)
    room.valid?
    expect(room.errors[:female]).to include("は一覧にありません")
  end

  it "statusがない場合、validationエラーが発生すること" do
    room = build(:room, status: nil)
    room.valid?
    expect(room.errors[:status]).to include("は一覧にありません")
  end

  it "statusが1~3以外の場合、validationエラーが発生すること" do
    room = build(:room, status: 5)
    room.valid?
    expect(room.errors[:status]).to include("は一覧にありません")
  end

  # it "roomが満員のときstatusがtrueを返すこと" do
  #   room = build(:full_room)
  #   expect(room.status).to be_truthy
  # end
  #
  # it "roomが満員でないときstatusがfalseを返すこと" do
  #   room = build(:room)
  #   expect(room.status).to be_falsey
  # end

end
