require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  shared_examples 'redirects to room#index' do
    it "room#indexにリダイレクトされること" do
      request
      expect(response).to redirect_to root_path
    end
  end

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

      it "rooms#roomにリダイレクトされること" do
        request
        expect(response).to redirect_to room_path
      end

      context "roomが満員でない場合" do
        before(:each){ @room = create(:room, :with_users, male: 1, female: 0) }

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
    end

    context "正しい値でない場合" do
      let(:request){ post :casting, user: attributes_for(:user, name: nil) }
      it_behaves_like 'redirects to room#index'

      it "user dbに新規追加されないこと"  do
        expect{ request }.to change(User, :count).by(0)
      end
    end
  end


  describe "user access" do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    shared_examples 'assigns the requested user to @user' do
      it "@userに正しい値が代入されること" do
        request
        expect(assigns(:user)).to eq @user
      end
    end

    describe 'GET #room' do
      let(:request){ get :room }
      it_behaves_like 'assigns the requested user to @user'

      it ":room templateにレンダリングされること" do
        get :room
        expect(response).to render_template :room
      end
    end

    describe 'GET #vote' do
      let(:request){ get :vote }
      it_behaves_like 'assigns the requested user to @user'

      context "roomが満員の場合" do
        before :each do
          ['male', 'female', 'female'].each do |gender|
            create(:user, room_id: @user.room_id, gender: gender)
          end
          request
        end

        it ":vote templateがレンダリングされること" do
          expect(response).to render_template :vote
        end

        it "@candidatesの要素数が2であること" do
          expect(assigns(:candidates).size).to eq 2
        end

        it "@candidatesに候補userが代入されること" do
          expect(assigns(:candidates)).to eq @user.room.users.where(gender: 'female')
        end
      end

      context "roomが満員でない場合" do
        it_behaves_like 'redirects to room#index'
      end
    end

    describe "POST #wait" do
      let(:request){ post :wait, candidate: 2 }
      it_behaves_like 'assigns the requested user to @user'

      it "match dbに新規追加されること" do
        expect{ request }.to change(Match, :count).by(1)
      end

      it "room#matchingにリダイレクトされること" do
        request
        expect(response).to redirect_to matching_path
      end

    end

    describe 'GET #matching' do
      let(:request){ get :matching }
      before(:each){ create(:match, user_id: @user.id, vote_id: 10 ) }
      it_behaves_like 'assigns the requested user to @user'

      context "matchした場合(1->10, 10->1)" do
        before :each do
          @match2 = create(:match, user_id: 10, vote_id: @user.id )
          request
        end

        it "idの大きいuser(id:10)のroom_idが採用されること" do
          expect(assigns[:room_id]).to eq @match2.room_id
        end

        it "room#messageにリダイレクトされること" do
          expect(response).to redirect_to message_path(assigns[:room_id])
        end
      end

      context "matchしなかった場合" do
        context "1->10, 20->1" do
          before(:each){ create(:match, user_id: 20, vote_id: @user.id ) }
          it_behaves_like 'redirects to room#index'
        end

        context "1->10, 10->99" do
          before(:each){ create(:match, user_id: 10, vote_id: 99 ) }
          it_behaves_like 'redirects to room#index'
        end
      end

    end

    describe 'GET #message' do
      let(:match){ create(:match) }
      let(:request){ get :message, id: match.room_id }
      it_behaves_like 'assigns the requested user to @user'

      it ":message templateがレンダリングされること" do
        request
        expect(response).to render_template :message
      end
    end
  end

  describe "guest access" do
    describe 'GET #room' do
      let(:request){ get :room }
      it_behaves_like 'redirects to room#index'
    end

    describe 'GET #vote' do
      let(:request){ get :vote }
      it_behaves_like 'redirects to room#index'
    end

    describe 'POST #wait' do
      let(:request){ post :wait, candidate: 2 }
      it_behaves_like 'redirects to room#index'
    end

    describe 'GET #matching' do
      let(:request){ get :matching, candidate: 2 }
      it_behaves_like 'redirects to room#index'
    end

    describe 'GET #message' do
      let(:request){ post :wait, candidate: 2 }
      it_behaves_like 'redirects to room#index'
    end
  end
end
