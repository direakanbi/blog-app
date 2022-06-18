class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # , :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, dependent: :destroy, class_name: 'Like', foreign_key: 'author_id'

  validates :name, presence: true, length: { in: 1..100 }
  validates :bio, presence: true, length: { in: 1..5000 }

  # User::Roles
  # The available roles
  ROLES = %i[admin moderator author banned].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def most_recent_posts(limit_ = 3)
    # Posts.where(author_id: id).reverse.slice(0, limit_)
    posts.includes(:author).order(created_at: :desc).limit(limit_)
  end
end
