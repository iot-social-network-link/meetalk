class API < Grape::API
  prefix "api"

  version 'v1', :using => :path

  resource "user" do
	  # Register window_id on User Table: http://localhost:3000/api/v1/user
	  # Try below command on your terminal. if you get result true, it must be sccuess
	  # $ curl -X PUT http://localhost:3000/api/v1/user/1 -d "window_id=test2;"
	  #
  desc "Register window_id to User"
    params do
     requires :user_id, type: Integer
     requires :window_id, type: String
    end
    put ':user_id' do
	  User.find( params[:user_id] ).update(window_id: params[:window_id])
	end
  end

  resource "users" do
    # All User Info API: http://localhost:3000/api/v1/users
    desc "returns all users"
    get do
      User.all
    end

    # Users in the room API: http://localhost:3000/api/v1/users/:room_id
    desc "return a user in the room"
    params do
      requires :room_id, type: Integer
    end
    get ':room_id' do
      User.where(room_id: params[:room_id])
    end
  end

  resource "rooms" do
    # All Rooms Info API: http://localhost:3000/api/v1/rooms
	  desc "returns all rooms"
	  get do
		  Room.all
	  end
  end

  resource "room_full" do
    # Room Full API: http://localhost:3000/api/v1/room_full/:room_id
	  desc "return True when four member joined in the room"
    params do
      requires :room_id, type: Integer
    end
 	  get ':room_id' do
      room = Room.find(params[:room_id])
      if (room.male + room.female) == 4
        { result: true }
      else
        { result: false }
      end
	  end
  end

end
