require 'rails_helper'

RSpec.feature "Castings", type: :feature do

  # scenario "start casting", js: true do
  #   visit root_path
  #   expect(current_path).to eq root_path
  #
  #   expect{
  #     fill_in 'user[name]', with: 'user01'
  #     choose 'female'
  #     click_button 'CAST NOW'
  #   }.to change(User, :count).by(1).and change(Room, :count).by(1)
  #
  #   expect(current_path).to eq room_path
  #   expect(page).to have_content '４人集まるまで待ってね'
  #
  #   # save_and_open_page
  # end
  #
  # scenario "start video chat", js: true do
  #   room = Room.create
  #
  #   room.users.create(name: 'user01', gender: 'male')
  #   room.users.create(name: 'user02', gender: 'female')
  #   room.users.create(name: 'user03', gender: 'female')
  #
  #   visit root_path
  #   expect(current_path).to eq root_path
  #
  #   expect{
  #     fill_in 'user[name]', with: 'user04'
  #     choose 'male'
  #     click_button 'CAST NOW'
  #   }.to change(User, :count).by(1).and change(Room, :count).by(0)
  #
  #   binding.pry
  #
  #   user = User.find_by(name: 'user04')
  #   expect(user.room.status).to be_truthy
  #
  #   expect(current_path).to eq room_path
  #   expect(page).to_not have_content '４人集まるまで待ってね'
  # end

end
