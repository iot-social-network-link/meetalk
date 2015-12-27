class API < Grape::API
  prefix "api"

  version 'v1', :using => :path

  resource "user" do

  desc "Register window_id to User"
	  # Register window_id on User Table: http://localhost:3000/api/v1/user
	  # Try below command on your terminal. if you get result true, it must be sccuess
	  # $ curl -X PUT http://localhost:3000/api/v1/user/1 -d "window_id=test2;"
	  #
    params do
     requires :user_id, type: Integer
     requires :window_id, type: String
    end
    put ':user_id' do
	  if User.find_by(id: params[:user_id])
	     User.find_by(id: params[:user_id]).update(window_id: params[:window_id])
		 {result: true}
	  else
         {result: false}
      end
	end
  end




  resource "users" do

    desc "returns all users"
    # All User Info API: http://localhost:3000/api/v1/users
    get do
      User.all
    end

    desc "return a user in the room"
    # Users in the room API: http://localhost:3000/api/v1/users/:room_id
    params do
      requires :room_id, type: Integer
    end
    get ':room_id' do
      User.where(room_id: params[:room_id])
    end
  end


  resource "window_id" do
  desc "Get User information with window_id and room_id"
  # http://localhost:3000/api/v1/window_id/$window_id?room_id=$room_id
  # サンプルは以下
  # http://localhost:3000/api/v1/window_id/test2.xml?room_id=4
    params do
		requires :window_id, type: String
		requires :room_id, type: Integer
	end
	get ':window_id' do
		if params[:room_id]
         User.where(window_id: params[:window_id]).where(room_id: params[:room_id])
		else
         User.where(window_id: params[:window_id])
		end
	end
  end




  resource "rooms" do

	  desc "returns all rooms"
    # All Rooms Info API: http://localhost:3000/api/v1/rooms
	  get do
		  Room.all
	  end
  end





  resource "room_full" do

	  desc "return True when four member joined in the room"
    # Room Full API: http://localhost:3000/api/v1/room_full/:room_id
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
