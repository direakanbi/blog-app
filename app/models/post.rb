class Post < ApplicationRecord
  belongs_to :users, class_name: 'User', foreign_key: 'users_id'
  has_many :comments, foreign_key: 'posts_id'
  has_many :likes, foreign_key: 'posts_id'

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_save :update_posts_counter

  private

  def update_posts_counter
    users.increment!(:post_counter)
  end
end
