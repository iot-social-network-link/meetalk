class API < Grape::API
  prefix "api"

  version 'v1', :using => :path

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
