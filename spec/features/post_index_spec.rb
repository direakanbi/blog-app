require 'rails_helper'

RSpec.describe 'post', type: :system do
  context 'After post\'s index integration, ' do
    before(:each) do
      driven_by(:rack_test)

      @user = User.create(name: 'Edward',
                          photo: 'https://upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg',
                          bio: 'Full Stack Developer',
                          email: 'yara123@gmail.com')

      @user.confirm

      visit user_posts_path(@user.id)
    end

    it "I can see the user's profile picture." do
      expect(page).to have_css("img[src*='upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg']")
    end

    it "I can see the user's username." do
      expect(page).to have_content('Edward')
    end
  end

  context 'index page for post\'s' do
    before(:each) do
      driven_by(:rack_test)

      @user = User.create(name: 'Edward',
                          photo: 'https://upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg',
                          bio: 'Full Stack Developer',
                          email: 'yara123@gmail.com')

      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Post 1', text: 'First Post')

      Comment.create(author_id: @user.id, post_id: @post.id, text: 'First Comment')

      Like.create(author_id: @user.id, post_id: @post.id)

      visit user_posts_path(@user.id)
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts 1')
    end

    it "I can see a post's title." do
      expect(page).to have_content('Post 1')
    end

    it "I can see some of the post's body." do
      expect(page).to have_content('First Post')
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_content('First Comment')
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content('Comments 1')
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes 1')
    end
  end

  context 'pagination redirected and, ' do
    before(:each) do
      driven_by(:rack_test)

      @user = User.create(name: 'Edward', photo: 'https://upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg',
                          bio: 'Full Stack Developer',
                          email: 'yara123@gmail.com')
      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Post 1', text: 'First Post')

      visit user_posts_path(@user.id)
    end
    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content('Pagination')
    end

    it "When I click on a post, it redirects me to that post's show page." do
      click_link(@post.title)
      expect(current_path).to eql(user_post_path(@user.id, @post.id))
    end
  end
end
