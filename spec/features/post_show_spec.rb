require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Posts', type: :system do
  context 'After post show integration, ' do
    before(:each) do
      driven_by(:rack_test)

      @user = User.create(name: 'Edward', photo: 'https://upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg',
                          bio: 'Full Stack Developer',
                          email: 'yara123@gmail.com')
      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Post 1', text: 'First Post')

      @comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'First Comment')

      visit user_post_path(@user.id, @post.id)
    end

    it 'I can see the post\'s title' do
      expect(page).to have_content(@post.title)
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content(@post.author.name)
    end

    it 'I can see how many comments it has.' do
      expect(page).to have_content('Comments 1')
    end

    it 'I can see how many likes it has.' do
      expect(page).to have_content('Likes 0')
    end

    it 'I can see the post body.' do
      expect(page).to have_content(@post.text)
    end

    it 'I can see the username of each commentor.' do
      expect(page).to have_content(@comment.author.name)
    end

    it 'I can see the comment each commentor left.' do
      expect(page).to have_content(@comment.text)
    end
  end
end
# rubocop:enable Metrics/BlockLength
