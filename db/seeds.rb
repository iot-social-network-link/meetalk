# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(name: 'user01', room_id: 1, gender: 'male')
User.create(name: 'user02', room_id: 1, gender: 'male')
User.create(name: 'user03', room_id: 1, gender: 'female')
User.create(name: 'user04', room_id: 1, gender: 'female')

Room.create(male: 2, female: 2)
