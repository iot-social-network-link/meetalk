class Room < ActiveRecord::Base
	has_many :users

	validates :male, inclusion: { in: 0..Settings.room.capacity }
	validates :female, inclusion: { in: 0..Settings.room.capacity }
	validates :status, inclusion: { in: 1..3 }

	def self.casting(user_gender)
		room = nil
		if user_gender == 'male'
			room = self.find_by("male < ? and status = ?", Settings.room.capacity, 1)
		else
			room = self.find_by("female < ? and status = ?", Settings.room.capacity, 1)
		end
		room = self.new if room.nil?

		return room
	end
end
