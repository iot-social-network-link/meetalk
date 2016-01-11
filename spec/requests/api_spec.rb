# coding: utf-8

require 'rails_helper'

RSpec.describe 'API', type: :request do
  let(:json){ JSON.parse(response.body) }

  shared_examples 'check http_status' do
    it "正しくアクセスできること" do
      request
      expect(response).to have_http_status(:success)
    end
  end

  shared_examples 'return true' do
    it "trueを返すこと" do
      request
      expect(json['result']).to be_truthy
    end
  end

  shared_examples 'return false' do
    it "falseを返すこと" do
      request
      expect(json['result']).to be_falsey
    end
  end

  describe "GET /api/v1/users/:room_id" do
    let(:room){ create(:room, :with_users, male: 0, female: 1) }
    let(:request) { get "/api/v1/users/#{room.id}.json" }
    it_behaves_like 'check http_status'

    it "roomのuser情報を返すこと" do
      request
      expect(json.size).to eq 1

      user = room.users.first
      expect(json[0]['name']).to eq user.name
      expect(json[0]['gender']).to eq user.gender
    end
  end

  describe "GET api/v1/window_id/:window_id?room_id=:room_id" do
    let(:request){ get "/api/v1/window_id/#{window_id}.json?room_id=#{room_id}" }

    context "userが存在する場合" do
      let(:user){ create(:room, :with_users, male: 0, female: 1).users.first }
      let(:window_id){ user.window_id }
      let(:room_id){ user.room_id }
      before(:each){ user.update(window_id: 'test2') }

      it_behaves_like 'check http_status'

      it "user情報を返すこと" do
        request
        expect(json['name']).to eq user.name
        expect(json['gender']).to eq user.gender
      end
    end

    context "userが存在しない場合" do
      let(:window_id){ 'test2' }
      let(:room_id){ 99 }
      it_behaves_like 'check http_status'
      it_behaves_like 'return false'
    end
  end

  describe "GET api/v1/room_full/:room_id" do
    let(:request){ get "/api/v1/room_full/#{room.id}.json" }

    context "roomが満員の場合" do
      let(:room){ create(:full_room) }
      it_behaves_like 'check http_status'
      it_behaves_like 'return true'
    end

    context "roomが満員でない場合" do
      let(:room){ create(:room, male: 0, female: 1) }
      it_behaves_like 'check http_status'
      it_behaves_like 'return false'
    end
  end

  describe "PUT /api/v1/user/:user_id, :window_id" do
    let(:request){ put "/api/v1/user/#{user_id}.json", {window_id: 'test2'} }

    context "userが存在する場合" do
      let(:user){ create(:user) }
      let(:user_id){ user.id }
      it_behaves_like 'check http_status'
      it_behaves_like 'return true'

      it "window_idを更新できること" do
        request
        user.reload
        expect(user.window_id).to eq 'test2'
      end
    end

    context "userが存在しない場合" do
      let(:user_id){ 99 }
      it_behaves_like 'check http_status'
      it_behaves_like 'return false'
    end
  end

  describe "PUT /api/v1/leaving_user, :window_id" do
    let(:request){ put "/api/v1/leaving_user.json", {window_id: window_id} }

    context "userが存在する場合" do
      let(:room){ create(:room, :with_users) }
      let(:user){ room.users.first }
      let(:window_id){ user.window_id }
      before(:each) do
        user.update(window_id: 'test2')
        create(:user, room_id: room.id)
        room.reload
      end

      it_behaves_like 'check http_status'
      it_behaves_like 'return true'

      context "user statusがtrueの場合" do
        it "user statusがfalseに変更されること" do
          expect{
            request
            user.reload
          }.to change{ user.status }.from(true).to(false)
        end

        it "roomの人数が変更されること(male: 2->1)" do
          expect{
            request
            room.reload
          }.to change{ room.male }.from(2).to(1).and change{ room.female }.by(0)
        end
      end

      context "user statusがfalseの場合" do
        before(:each){ user.update(status: false) }

        it "user statusが変更されないこと" do
          expect{
            request
            user.reload
          }.to_not change{ user.status }
        end

        it "roomの人数が変更されないこと(male: 1->1)" do
          expect{
            request
            room.reload
          }.to change{ room.male }.by(0).and change{ room.female }.by(0)
        end
      end

      context "apiを3回叩いた場合" do
        it "1回目のみroomの人数が変更されること(male: 2->1)" do
          expect{
            request
            room.reload
          }.to change{ room.male }.from(2).to(1).and change{ room.female }.by(0)
          expect{
            request
            room.reload
          }.to change{ room.male }.by(0).and change{ room.female }.by(0)
          expect{
            request
            room.reload
          }.to change{ room.male }.by(0).and change{ room.female }.by(0)
        end
      end

    end

    context "userが存在しない場合" do
      let(:window_id){ 'test2' }
      it_behaves_like 'check http_status'
      it_behaves_like 'return false'
    end
  end

  describe "DELETE /api/v1/window_id/:window_id?room_id=:room_id" do
    let(:request){ delete "/api/v1/window_id/#{window_id}.json?room_id=#{room_id}" }

    context "userが存在する場合" do
      let(:user){ create(:room, :with_users).users.first }
      let(:window_id){ user.window_id }
      let(:room_id){ user.room_id }
      before(:each){ user.update(window_id: 'test2') }

      it_behaves_like 'check http_status'
      it_behaves_like 'return true'

      it "userが削除されること" do
        expect{ request }.to change(User, :count).by(-1)
      end
    end

    context "userが存在しない場合" do
      let(:window_id){ 'test2' }
      let(:room_id){ 99 }
      it_behaves_like 'check http_status'
      it_behaves_like 'return false'
    end
  end
end
