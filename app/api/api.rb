class API < Grape::API
  prefix "api"
  version 'v1', :using => :path

  resource "user" do
    desc "Register window_id to User"
    # Register window_id on User Table: http://localhost:3000/api/v1/user
    # Try below command on your terminal. if you get result true, it must be sccuess
    # $ curl -X PUT http://localhost:3000/api/v1/user/1 -d "window_id=test2"
    params do
      requires :user_id, type: Integer
      requires :window_id, type: String
    end
    put ':user_id' do
      user = User.find_by_id(params[:user_id])
      if user.present?
        return { result: true } if user.update(window_id: params[:window_id])
      end
      return { result: false }
    end
  end

  resource "users" do
    desc "returns all users"
    # All User Info API: http://localhost:3000/api/v1/users
    get do
      return User.all
    end

    desc "return a user in the room"
    # Users in the room API: http://localhost:3000/api/v1/users/:room_id
    params do
      requires :room_id, type: Integer
    end
    get ':room_id' do
      return User.where(room_id: params[:room_id])
    end
  end

  resource "window_id" do
    desc "Get User information with window_id and room_id"
    # http://localhost:3000/api/v1/window_id/$window_id?room_id=$room_id
    params do
      requires :window_id, type: String
      requires :room_id, type: Integer
    end
    get ':window_id' do
      user = User.find_by(window_id: params[:window_id], room_id: params[:room_id])
      if user.nil?
        return { result: false }
      else
        return user
      end
    end

    desc "Delete User with window_id and room_id"
    # curl -X DELETE http://localhost:3000/api/v1/window_id/$window_id?room_id=$room_id
    params do
      requires :window_id, type: String
      requires :room_id, type: Integer
    end
    delete ':window_id' do
      user = User.find_by(window_id: params[:window_id], room_id: params[:room_id])
      if user.nil?
        return { result: false }
      else
        if User.delete(user.id)
         return { result: true } 
        else 
         return { result: false} 
        end
      end
    end




  end

  resource "rooms" do
	  desc "returns all rooms"
    # All Rooms Info API: http://localhost:3000/api/v1/rooms
	  get do
		  return Room.all
	  end
  end

  resource "room_full" do
	  desc "return True when four member joined in the room"
    # Room Full API: http://localhost:3000/api/v1/room_full/:room_id
    params do
      requires :room_id, type: Integer
    end
 	  get ':room_id' do
      room = Room.find_by_id(params[:room_id])
      if room.nil?
        return { result: false }
      else
        return { result: room.status }
      end
  	end
  end

end
