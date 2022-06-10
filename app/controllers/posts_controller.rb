class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.users_id)
  end

  def create
    new_post = current_user.posts.new(params.require(:post).permit(:title, :text))
    new_post.likes_counter = 0
    new_post.comments_counter = 0
    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to "/users/#{new_post.users.id}/posts"
        else
          render :new
        end
      end
    end
  end
end
