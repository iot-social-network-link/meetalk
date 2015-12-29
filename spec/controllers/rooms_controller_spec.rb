require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #casting' do
    context "with valid attributes" do
      it "save the new user in the database" do
        expect{
          post :casting, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      context "when there is empty room" do
        before :each do
          @room = create(:room, male: 1)
        end

        it "changes the room in the database" do
          post :casting, user: attributes_for(:user)
          @room.reload
          expect(@room.male).to eq(2)
        end

        it "doesn't save the new room in the database" do
          expect{
            post :casting, user: attributes_for(:user)
          }.to change(Room, :count).by(0)
        end
      end

      context "when there is not empty room" do
        it "save the new room in the database" do
          expect{
            post :casting, user: attributes_for(:user)
          }.to change(Room, :count).by(1)
        end
      end

      it "redirects to rooms#room" do
        post :casting, user: attributes_for(:user)
        expect(response).to redirect_to room_path
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new user in the database"
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

      # 4人いるとき
      context "when there is not empty room" do
        it "renders the :vote template"
        # it "renders the :vote template" do
        #   get :vote
        #   expect(response).to render_template :vote
        # end
      end

      # 4人いないとき
      context "when there is empty room" do
        it "redirect to room#index" do
          get :vote
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe "guest access" do
    describe 'GET #room' do
      it "redirect to room#index" do
        get :room
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET #vote' do
      it "redirect to room#index" do
        get :vote
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #matching' do
    context "match" do
      it "redirect to room#message" do
        create(:match, my_id: 2, vote_id: 1)
        post :matching, user: {id: 1}, candidate: 2
        expect(response).to redirect_to message_path(assigns[:room_id])
      end
    end
    context "not match" do
      it "redirect to room#index" do
        create(:match, my_id: 2, vote_id: 3)
        post :matching, user: {id: 1}, candidate: 2
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #message' do
    it "renders the :index template" do
      match = build(:match)
      get :message, id: match.room_id
      expect(response).to render_template :message
    end
  end

end
