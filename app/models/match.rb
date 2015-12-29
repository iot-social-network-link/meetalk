class Match < ActiveRecord::Base
  validates :my_id, presence: true
  validates :vote_id, presence: true
  validates :room_id, presence: true
end
