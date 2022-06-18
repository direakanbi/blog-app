module ApplicationHelper
  def posts_per_page
    3
  end

  def author_posts_more_than?(user, limit_ = 2)
    user.posts.count > limit_
  end

  def flash_messages_for(_object)
    render(partial: 'layout/flash', locals: ' object: ')
  end

  def image_control(image_url)
    avatars = ['avatar1.png', 'avatar2.png', 'boy.png', 'delivery_boy.png']
    unless image_url&.end_with?('png') or image_url&.end_with?('jpg') or
           image_url&.end_with?('gif') or image_url&.end_with?('jpeg')
      return avatars[(rand * avatars.length).to_i]
    end

    image_url
  end
end
