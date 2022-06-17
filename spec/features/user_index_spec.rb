require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  describe 'After user\'s index integration, ' do
    before(:each) do
      @photo = 'https://upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg'
      @first_user = User.create!(name: 'Tom',
                                 photo: @photo,
                                 password: 'root18',
                                 email: 'yara123@gmail.com',
                                 posts_counter: 0,
                                 confirmed_at: Time.now)

      @second_user = User.create!(name: 'Lilly',
                                  photo: @photo,
                                  password: 'root12',
                                  email: 'lil@icloud.com',
                                  confirmed_at: Time.now)

      visit new_user_session_path

      fill_in 'Email', with: 'yara123@gmail.com'
      fill_in 'Password', with: 'root18'
      click_button 'Log in'

      visit root_path
    end

    it 'I can see the username of all other users.' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Lilly')
    end

    it 'I can see the profile picture for each user.' do
      image = page.all('img')
      expect(image.size).to eql(2)
    end

    it 'I can see the number of posts each user has written.' do
      expect(page).to have_content('Number of posts 0')
    end

    it 'When I click on a user, I am redirected to that user\'s show page.' do
      click_link @first_user.name
      expect(page).to have_current_path(user_path(@first_user.id))
    end
  end
end
