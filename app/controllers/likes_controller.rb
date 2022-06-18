class LikesController < ApplicationController
  # skip_before_action :verify_authenticity_token
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html do
        if current_user
          new_like = Like.new(author_id: current_user.id, post_id: params[:id])
          if Like.exists?(author_id: current_user.id, post_id: params[:id])
            likes = Like.all.where(author_id: current_user.id, post_id: params[:id])
            likes.each(&:destroy)
          elsif new_like.save
            # flash like
          else
            flash.now[:error] = 'An error occured'
          end
          redirect_back fallback_location: root_path
        else
          flash.now[:error] = 'Log In to give likes'
          redirect_to user_session_path
        end
      end
    end
  end
end
