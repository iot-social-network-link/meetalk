class Match < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :vote_id, presence: true

  after_create :create_room_id

  private
  def create_room_id
    chars = (0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a
    self.update( room_id: chars.sample(Settings.match.roomid_num).join )
  end
end
