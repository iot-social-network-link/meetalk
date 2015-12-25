class RoomsController < ApplicationController
  def index
  end

  def casting
    room = nil
    if params[:gender] == 'male'
      room = Room.find_by("male < #{Settings.room.capacity}")
    else
      room = Room.find_by("female < #{Settings.room.capacity}")
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

    User.create(
      name: params[:name],
      gender: params[:gender],
      room_id: room.id
    )

    redirect_to :action => "room", :id => room.id
  end

  def matching
    @user = User.find(params[:id])
    room = @user.room

    @candidates = Array.new
    if @user.gender == 'male'
      @candidates = room.user.where(gender: 'female')
    else
      @candidates = room.user.where(gender: 'male')
    end
  end

  def waiting

    # user_id =  params[:user][:id]
    #
    # params[:candidate]
    #
    #
    # binding.pry
    #
    # sleep(5)


  end

  def message
  end

  def room
  end
end
