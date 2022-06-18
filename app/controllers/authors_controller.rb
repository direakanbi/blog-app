class AuthorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @authors = User.all.reverse
  end

  def show
    @user = begin
      User.find(params[:id])
    rescue StandardError
      nil
    end

    @user_posts = @user.most_recent_posts(2)
  end
end
