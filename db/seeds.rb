# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

room = Room.create(male: 1, female: 2)

room.users.create(name: 'user02', gender: 'male')
room.users.create(name: 'user03', gender: 'female')
room.users.create(name: 'user04', gender: 'female')
