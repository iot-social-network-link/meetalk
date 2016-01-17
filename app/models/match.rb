class Match < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :vote_id, presence: true

  after_create :create_room_id

  def self.check(user_id)
    match1 = self.find_by(user_id: user_id)
    match2 = self.find_by(user_id: match1.vote_id, vote_id: user_id)

    if match2.nil?
      if self.find_by(user_id: match1.vote_id).nil?
        return { result: "wait" }
      else
        return { result: "unmatch" }
      end
    else
      room_id = (match1.user_id > match1.vote_id) ? match1.room_id : match2.room_id
      return { result: "match", room_id: room_id }
    end
  end

  private
  def create_room_id
    chars = (0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a
    self.update( room_id: chars.sample(Settings.match.roomid_num).join )
  end
end
