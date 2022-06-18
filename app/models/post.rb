class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes, dependent: :destroy
  validates :author_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { in: 1..100 }
  validates :text, presence: true, length: { in: 1..5000 }

  after_save :update_post_counter_of_user
  after_destroy -> { update_post_counter_of_user('down') }

  def most_recent_comments(limit_ = 5)
    comments.order(created_at: :desc).limit(limit_)
  end

  def comments_with_author_names(limit_ = 5)
    # comments.joins(:author).select('comments.*, users.name as name').order(created_at: :desc).limit(limit_)
    # comments = Comment.includes(:author).where(post_id: self.id)
    comments.includes(:author).limit(limit_)
  end

  def user_liked_this_post?(user_id)
    Like.exists?(post_id: id, author_id: user_id)
  end

  private

  def update_post_counter_of_user(arg = 'up')
    case arg
    when 'up'
      author.increment!(:posts_counter)
    when 'down'
      author.decrement!(:posts_counter)
    end
  end
end
