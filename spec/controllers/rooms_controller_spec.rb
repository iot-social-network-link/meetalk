require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  describe 'GET #index' do
    it ":index templateがレンダリングされること" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #casting' do
    context "正しい値の場合" do
      let(:request){ post :casting, user: attributes_for(:user) }

      it "user dbに新規追加されること" do
        expect{ request }.to change(User, :count).by(1)
      end

      context "roomが満員でない場合" do
        before :each do
          @room = create(:room, :with_users, male: 1, female: 0)
        end

        it "room dbの値が更新されること" do
          request
          @room.reload
          expect(@room.male).to eq(2)
        end

        it "room dbに新規追加されないこと" do
          expect{ request }.to change(Room, :count).by(0)
        end
      end

      context "roomが満員の場合" do
        it "room dbに新規追加されること" do
          create(:full_room)
          expect{ request }.to change(Room, :count).by(1)
        end
      end

      it "rooms#roomにリダイレクトされること" do
        request
        expect(response).to redirect_to room_path
      end
    end

    context "正しい値でない場合" do
      let(:request){ post :casting, user: attributes_for(:user, name: nil) }

      it "user dbに新規追加されないこと"  do
        expect{ request }.to change(User, :count).by(0)
      end

      it "rooms#indexにリダイレクトされること" do
        request
        expect(response).to redirect_to root_path
      end
    end
  end


  describe "user access" do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    describe 'GET #room' do
      it "assigns the requested user to @user" do
        get :room
        expect(assigns(:user)).to eq @user
      end

      it "renders the :room template" do
        get :room
        expect(response).to render_template :room
      end
    end

    describe 'GET #vote' do
      it "assigns the requested user to @user" do
        get :vote
        expect(assigns(:user)).to eq @user
      end

      context "roomが満員の場合" do
        it ":vote templateがレンダリングされること" do
          ['male', 'female', 'female'].each do |gender|
            create(:user, room_id: @user.room_id, gender: gender)
          end
          get :vote
          expect(response).to render_template :vote
        end
      end

      context "roomが満員でない場合" do
        it "room#indexにリダイレクトされること" do
          get :vote
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "POST #wait" do
      let(:request){ post :wait, candidate: 2 }

      it "match dbに新規追加されること" do
        expect{ request }.to change(Match, :count).by(1)
      end

      it "room#matchingにリダイレクトされること" do
        request
        expect(response).to redirect_to matching_path
      end

    end

    describe 'GET #matching' do
      let(:vote_id){ 10 }
      let(:request){ post :matching, candidate: vote_id }
      before :each do
        create(:match, my_id: @user.id, vote_id: vote_id )
      end

      context "matchした場合" do
        it "room#messageにリダイレクトされること" do
          create(:match, my_id: vote_id, vote_id: @user.id )
          request
          expect(response).to redirect_to message_path(assigns[:room_id])
        end
      end

      context "matchしなかった場合" do
        it "room#indexにリダイレクトされること" do
          create(:match, my_id: vote_id, vote_id: 99 )
          request
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe "guest access" do
    describe 'GET #room' do
      it "room#indexにリダイレクトされること" do
        get :room
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET #vote' do
      it "room#indexにリダイレクトされること" do
        get :vote
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #message' do
    it ":message templateがレンダリングされること" do
      match = build(:match)
      get :message, id: match.room_id
      expect(response).to render_template :message
    end
  end

end
