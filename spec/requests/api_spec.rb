require 'rails_helper'

RSpec.describe 'API', type: :request do

  describe "GET /api/v1/users/:room_id" do
    before :each do
      @room = create(:room, male: 0, female: 1)
      get "/api/v1/users/#{@room.id}.json"
    end

    it "正しくアクセスできること" do
      expect(response).to have_http_status(:success)
    end

    it "roomのuser情報を返すこと" do
      json = JSON.parse(response.body)
      expect(json.size).to eq 1

      user = @room.users.first
      expect(json[0]['name']).to eq user.name
      expect(json[0]['gender']).to eq user.gender
    end
  end

  describe "GET api/v1/window_id/:window_id?room_id=:room_id" do
    it "user情報を返すこと"
    # user_idではだめ？そもそも必要？
  end

  describe "GET api/v1/room_full/:room_id" do
    context "roomが満員の場合" do
      before :each do
        room = create(:full_room)
        get "/api/v1/room_full/#{room.id}.json"
      end

      it "正しくアクセスできること" do
        expect(response).to have_http_status(:success)
      end

      it "trueを返すこと" do
        json = JSON.parse(response.body)
        expect(json['result']).to be_truthy
      end
    end

    context "roomが満員でない場合" do
      before :each do
        room = create(:room, male: 0, female: 1)
        get "/api/v1/room_full/#{room.id}.json"
      end

      it "正しくアクセスできること" do
        expect(response).to have_http_status(:success)
      end

      it "falseを返すこと" do
        json = JSON.parse(response.body)
        expect(json['result']).to be_falsey
      end
    end
  end

  describe "PUT /api/v1/user/:user_id" do
    context "userが存在する場合" do
      before :each do
        @user = create(:user)
        put "/api/v1/user/#{@user.id}.json", {window_id: 'test2'}
      end

      it "正しくアクセスできること" do
        expect(response).to have_http_status(:success)
      end

      it "trueを返すこと" do
        json = JSON.parse(response.body)
        expect(json['result']).to be_truthy
      end

      it "window_idを更新できること" do
        @user.reload
        expect(@user.window_id).to eq 'test2'
      end
    end

    context "userが存在しない場合" do
      before :each do
        put "/api/v1/user/99.json", {window_id: 'test2'}
      end

      it "正しくアクセスできること" do
        expect(response).to have_http_status(:success)
      end

      it "falseを返すこと" do
        json = JSON.parse(response.body)
        expect(json['result']).to be_falsey
      end
    end
  end

  # user_idのほうがいいのでは？
  describe "DELETE /api/v1/window_id/:window_id?room_id=:room_id" do
    before :each do
      user = create(:room).users.first
      user.update(window_id: 'test2')
      delete "/api/v1/window_id/#{user.window_id}?room_id=#{user.room_id}.json"
    end

    it "正しくアクセスできること" do
      expect(response).to have_http_status(:success)
    end

    it "trueを返すこと" do
      json = JSON.parse(response.body)
      expect(json['result']).to be_truthy
    end

    it "userが削除されること"
    # it "userが削除されること" do
    #   expect{ request }.to change(User, :count).by(-1)
    # end
  end

end
