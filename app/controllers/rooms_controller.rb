class RoomsController < ApplicationController
  CAPACITY = 2

  def index
  end

  def casting
    room = nil
    if params[:gender] == 'male'
      room = Room.find_by("male < #{CAPACITY}")
    else
      room = Room.find_by("female < #{CAPACITY}")
    end
    if room.nil?
      room = Room.new(male: 0, female: 0)
    end

    if params[:gender] == 'male'
      room.male += 1
    else
      room.female += 1
    end
    room.save

	# User DBに情報登録
	user = User.new(nickname:params[:name] , room_id: room.id)
	user.save
	

    redirect_to :action => "room", :id => room.id
  end

  def room
  end
end
