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
        # post :casting, user: attributes_for(:user)
        expect{
          post :casting, name: 'name01', gender: 'male'
        }.to change(User, :count).by(1)
      end

      context "when there is empty room" do
        before :each do
          @room = create(:room, male: 1)
        end

        it "changes the room in the database" do
          post :casting, name: 'name01', gender: 'male'
          @room.reload
          expect(@room.male).to eq(2)
        end

        it "doesn't save the new room in the database" do
          expect{
            post :casting, name: 'name01', gender: 'male'
          }.to change(Room, :count).by(0)
        end
      end

      context "when there is not empty room" do
        it "save the new room in the database" do
          expect{
            post :casting, name: 'name01', gender: 'male'
          }.to change(Room, :count).by(1)
        end
      end

      it "redirects to rooms#room" do
        post :casting, name: 'name01', gender: 'male'
        expect(response).to redirect_to room_path(assigns[:user].id)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new user in the database"
    end
  end

  describe 'GET #room' do
    context "with valid attributes" do
      it "assigns the requested user to @user" do
        user = create(:user)
        get :room, id: user.id
        expect(assigns(:user)).to eq user
      end

      it "renders the :room template" do
        user = create(:user)
        get :room, id: user.id
        expect(response).to render_template :room
      end
    end

    context "with invalid attributes" do
      it "redirect to rooms#index" do
        get :room, id: 1
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #vote' do
    context "with valid attributes" do
      it "assigns the requested user to @user" do
        user = create(:user)
        get :vote, id: user.id
        expect(assigns(:user)).to eq user
      end

      it "renders the :vote template" do
        user = create(:user)
        get :vote, id: user.id
        expect(response).to render_template :vote
      end
    end

    context "with invalid attributes" do
      it "redirect to room#index" do
        get :vote, id: 1
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
