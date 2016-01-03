class User < ActiveRecord::Base
	belongs_to :room
	has_one :match

	validates :name, length: { in: 2..10 }
	validates :gender, inclusion: { in: %w(male female) }
	# validates :room_id, presence: true

	after_create :update_room_member

	private
	def update_room_member
		count = User.where(room_id: self.room_id).group(:gender).count
		self.room.update(count)
	end
end
