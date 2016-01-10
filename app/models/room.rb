class Room < ActiveRecord::Base
	has_many :users

	validates :male, inclusion: { in: 0..Settings.room.capacity }
	validates :female, inclusion: { in: 0..Settings.room.capacity }
	validates :status, inclusion: { in: 1..3 }

	def self.casting(user_gender)
		room = nil
		if user_gender == 'male'
			room = self.find_by("male < #{Settings.room.capacity}")
		else
			room = self.find_by("female < #{Settings.room.capacity}")
		end
		room = self.new if room.nil?

		return room
	end
end
