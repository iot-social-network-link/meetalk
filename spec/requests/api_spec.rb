require 'rails_helper'

RSpec.describe 'API', type: :request do

  describe "GET /api/v1/users/:room_id" do
    it "roomのuser情報を返すこと" do
      room = create(:room, male: 0, female: 1)

      get "/api/v1/users/#{room.id}.json"
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json.size).to eq 1

      user = room.users.first
      expect(json[0]['name']).to eq user.name
      expect(json[0]['gender']).to eq user.gender
    end
  end

  describe "GET api/v1/window_id/:window_id?room_id=:room_id" do
    it "user情報を返すこと"
    # user_idではだめ？そもそも必要？
  end

  describe "GET api/v1/room_full/:room_id" do
    it "roomが満員のとき、trueを返すこと" do
      room = create(:full_room)

      get "/api/v1/room_full/#{room.id}.json"
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json['result']).to be_truthy
    end

    it "roomが満員でないとき、falseを返すこと" do
      room = create(:room, male: 0, female: 1)

      get "/api/v1/room_full/#{room.id}.json"
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json['result']).to be_falsey
    end
  end

  describe "PUT /api/v1/user/:user_id" do
    it "userが存在する場合、trueを返し、windows_idを更新できること" do
      user = create(:user)

      put "/api/v1/user/#{user.id}.json", {window_id: 'test2'}
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json['result']).to be_truthy

      user.reload
      expect(user.window_id).to eq 'test2'
    end

    it "userが存在しない場合、falseを返すこと"
  end

  describe "DELETE /api/v1/window_id/:window_id?room_id=:room_id" do
    it "userが削除されること"
    # user_idのほうがいいのでは？
  end

end
