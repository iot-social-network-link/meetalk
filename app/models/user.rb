class User < ActiveRecord::Base
	belongs_to :room

	validates :name, length: { in: 2..10 }
	validates :gender, inclusion: { in: %w(male female) }
	validates :room_id, presence: true
end
