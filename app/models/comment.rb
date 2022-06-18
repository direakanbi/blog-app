class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :author_id, presence: true, numericality: { only_integer: true }
  validates :post_id, presence: true, numericality: { only_integer: true }
  validates :text, presence: true, length: { in: 1..2000 }

  after_save :update_comments_counter_of_post
  after_destroy -> { update_comments_counter_of_post('down') }

  private

  def update_comments_counter_of_post(arg = 'up')
    case arg
    when 'up'
      post.increment!(:comments_counter)
    when 'down'
      post.decrement!(:comments_counter)
    end
  end
end
