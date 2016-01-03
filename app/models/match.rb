class Match < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :vote_id, presence: true
  validates :room_id, presence: true
end
