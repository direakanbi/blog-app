require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe 'Devise sessions', type: :system do
  context 'After Login page loads, ' do
    before(:each) do
      driven_by(:rack_test)

      @user = User.create(name: 'Edward', photo: 'https://img.icons8.com/color/48/000000/instagram-new--v2.png',
                          bio: 'Full Stack Developer',
                          email: 'oluyaratosin123@gmail.com',
                          password: 'Yara123#@', password_confirmation: 'Yara123#@')
      @user.confirm

      visit new_user_session_path
    end

    it 'I can see the username input field' do
      expect(page).to have_field('Email')
    end

    it 'I can see the passwword input field' do
      expect(page).to have_field('Password')
    end

    it 'I can see the "Submit" button' do
      click_button('Log in')
    end

    it 'When I click the submit button without filling in the username and the password,
        I get a detailed error.' do
      click_button('Log in')
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'When I click the submit button after filling in the username and the password with incorrect data,
        I get a detailed error.' do
      fill_in('Email', with: 'e@gmail.com')
      fill_in('Password', with: '123456')
      click_button('Log in')
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'When I click the submit button after filling in the username and the password with correct data,
        I am redirected to the root page.' do
      fill_in('Email', with: 'oluyaratosin123@gmail.com')
      fill_in('Password', with: 'Yara123#@')
      click_button('Log in')

      expect(page).to have_content('Signed in successfully')
      expect(page).to have_current_path '/'
    end
  end
end
# rubocop:enable Metrics/BlockLength
