class User < ActiveRecord::Base
	belongs_to :room
	has_one :match

	validates :name, length: { in: 2..10 }
	validates :gender, inclusion: { in: %w(male female) }
	validates :status, inclusion: { in: [true, false] }
	# validates :room_id, presence: true

	after_save :update_room

	private
	def update_room
		count = User.where(room_id: self.room_id).group(:gender).count
		self.room.male = count['male'] || 0
		self.room.female = count['female'] || 0

		if self.room.status == 1 and self.room.male + self.room.female == Settings.room.capacity * 2
			self.room.status = 2
		end

		self.room.save
	end
end
