class User < ApplicationRecord
  has_many :posts, foreign_key: 'users_id'
  has_many :comments, foreign_key: 'posts_id'
  has_many :likes, foreign_key: 'posts_id'

  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
