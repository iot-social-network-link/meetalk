require 'rails_helper'

RSpec.feature "Castings", type: :feature do

  scenario "start casting", js: true do
  # scenario "start casting" do

    visit root_path

    expect{
      fill_in 'name', with: 'username'
      choose 'female'
      click_button 'CAST NOW'
    }.to change(User, :count).by(1).and change(Room, :count).by(1)

    expect(current_path).to eq room_path(1)
    # expect(page).to have_content 'name: hogehoge'
    # expect(page).to have_content 'gen: female'

    # save_and_open_page
  end

end
