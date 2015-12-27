class RoomsController < ApplicationController
  def index
  end

  def casting
    room = Room.casting(params[:gender])
    user = User.create(
      name: params[:name],
      gender: params[:gender],
      room_id: room.id
    )

    redirect_to :action => "room", :id => user.id
  end

  def room
    gon.user = User.find(params[:id])
  end

  def vote
    @user = User.find(params[:id])
    room = @user.room

    @candidates = Array.new
    if @user.gender == 'male'
      @candidates = room.user.where(gender: 'female')
    else
      @candidates = room.user.where(gender: 'male')
    end
  end

  def matching
    my_id = params[:user][:id]
    vote_id = params[:candidate]
    room_id = ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(Settings.match.roomid_num).join

    match1 = Match.create(
      my_id: my_id,
      vote_id: vote_id,
      room_id: room_id
    )

    # 投票待ち
    sleep(Settings.match.vote_time)

    match2 = Match.find_by(my_id: vote_id, vote_id: my_id)
    if match2.nil?
      # not match
      redirect_to :action => "index"
    else
      # match
      room_id = (my_id > vote_id) ? match1.room_id : match2.room_id
      redirect_to :action => "message", :id => room_id
    end
  end

  def message
  end
end
