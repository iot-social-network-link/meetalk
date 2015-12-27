class Room < ActiveRecord::Base
	has_many :user

	def self.casting(user_gender)
		room = nil

		if user_gender == 'male'
      room = self.find_by("male < #{Settings.room.capacity}")
    else
      room = self.find_by("female < #{Settings.room.capacity}")
		end

    if room.nil?
      room = self.new(male: 0, female: 0)
    end

    if user_gender == 'male'
      room.male += 1
    else
      room.female += 1
    end
    room.save

		return room
	end
end
