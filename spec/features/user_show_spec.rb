require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
  describe 'After user show integration, ' do
    before(:each) do
      @photo = 'https://upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg'
      @user = User.create!(name: 'Tom',
                           photo: @photo,
                           password: 'root17',
                           email: 'yara123@gmail.com',
                           bio: 'Full Stack Developer',
                           confirmed_at: Time.now)

      visit new_user_session_path

      fill_in 'Email', with: 'yara123@gmail.com'
      fill_in 'Password', with: 'root17'
      click_button 'Log in'

      @first_post = Post.create!(author: @user,
                                 title: 'Post 1',
                                 text: 'Post text 1',
                                 likes_counter: '0',
                                 comments_counter: '0')

      @second_post = Post.create!(author: @user,
                                  title: 'Post 2',
                                  text: 'Post text 2',
                                  likes_counter: '0',
                                  comments_counter: '0')

      @third_post = Post.create!(author: @user,
                                 title: 'Post 3',
                                 text: 'Post text 3',
                                 likes_counter: '0',
                                 comments_counter: '0')

      click_link 'Tom'
    end

    it 'I can see the user\'s profile picture.' do
      image = page.all('img')
      expect(image.size).to eql(1)
    end

    it 'I can see the user\'s username.' do
      expect(page).to have_content('Tom')
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts')
    end

    it 'I can see the user\'s bio.' do
      expect(page).to have_content('Full Stack Developer')
      visit user_session_path
    end

    it 'I can see the user\'s first 3 posts.' do
      expect(page).to have_content 'Post 1'
      expect(page).to have_content 'Post 2'
      expect(page).to have_content 'Post 3'
    end

    it 'I can see a button that lets me view all of a user\'s posts.' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user.id))
    end

    it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      click_link 'Post 1'
      expect(page).to have_current_path user_post_path(@user, @first_post)
    end
  end
end
