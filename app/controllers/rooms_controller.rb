class RoomsController < ApplicationController
  before_action :set_user, only: [:room, :vote, :wait, :matching, :message]
  before_action :set_js_const, only: [:index, :room, :vote, :message]

  # GET /
  def index
    @user = User.new
  end

  # POST /casting
  def casting
    room = Room.casting(params[:user][:gender])
    render :index unless room.save

    @user = room.users.new(params[:user].permit(:name, :gender))
    if @user.save
      session[:user_id] = @user.id
      redirect_to :action => "room"
    else
      redirect_to :action => "index"
    end
  end

  # GET /room
  def room
    gon.user = @user
  end

  # GET /vote
  def vote
    redirect_to :action => "index" unless @user.room.status

    @candidates = Array.new
    if @user.gender == 'male'
      @candidates = @user.room.users.where(gender: 'female')
    else
      @candidates = @user.room.users.where(gender: 'male')
    end
  end

  # POST /wait
  def wait
    room_id = ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(Settings.match.roomid_num).join
    Match.create( my_id: @user.id, vote_id: params[:candidate], room_id: room_id )

    # 投票待ち
    sleep(Settings.match.vote_time)

    redirect_to :action => "matching"
  end

  # GET /matching
  def matching
    match2 = Match.find_by(vote_id: @user.id)
    if match2.nil?
      # not match
      redirect_to :action => "index"
    else
      # match
      match1 = Match.find_by(my_id: @user.id)
      @room_id = (match1.my_id > match1.vote_id) ? match1.room_id : match2.room_id
      redirect_to :action => "message", :id => @room_id
    end
  end

  # GET /message/1
  def message
    gon.user = @user
    gon.room_id = params[:id]
  end

  private
  def set_user
    @user ||= User.find_by_id(session[:user_id])
    redirect_to :action => "index" if @user.nil?
  end

  def set_js_const
    gon.const = Settings.js
  end

end
