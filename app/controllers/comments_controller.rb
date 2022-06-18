class CommentsController < ApplicationController
  load_and_authorize_resource
  # skip_before_action :verify_authenticity_token

  SUCCESS_MSG = 'Comment saved successfully'.freeze
  ERROR_MSG = 'Error: Comment could not be saved'.freeze

  def create
    new_comment = Comment.new(create_params)
    new_comment.author_id = current_user.id

    respond_to do |new|
      if new_comment.save
        new.html do
          # success message
          flash[:success] = SUCCESS_MSG
          redirect_to author_post_path(params[:author_id], params[:post_id])
        end
        new.xml { render xml: SUCCESS_MSG }
        new.json { render json: SUCCESS_MSG }
      else
        new.html do
          # error message
          flash.now[:error] = ERROR_MSG
          redirect_back
          redirect_to author_post_path(params[:author_id], params[:post_id])
        end
        new.xml { render xml: ERROR_MSG }
        new.json { render json: ERROR_MSG }
      end
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = 'Comment deleted successfully'
    else
      flash[:error] = 'Error: Comment could not be deleted'
    end
    redirect_back(fallback_location: root_path)
  end

  def index
    comments = Post.find(params[:post_id]).comments
    respond_to do |format|
      format.xml { render xml: comments }
      format.json { render json: comments }
    end
  end

  private

  # use create_ for cancancan
  def create_params
    params.require(:comment).permit(:text, :post_id)
  end
end
