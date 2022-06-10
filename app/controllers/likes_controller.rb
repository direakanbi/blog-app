class LikesController < ApplicationController
  def create
    @post = Post.find(params[:posts_id])
    if current_user.likes.find_by(users_id: @post.users_id, posts_id: @post.id)
      redirect_to "/users/#{@post.users_id}/posts/#{@post.id}"
    else
      new_like = current_user.likes.new
      new_like.posts_id = @post.id
      if new_like.save
        redirect_to "/users/#{@post.users_id}/posts/#{@post.id}", notice: 'Likeds Successfully'
      else
        redirect_to "/users/#{@post.users_id}/posts/#{@post.id}", alert: 'Sorry, Something Went Wrong'
      end
    end
  end
end
