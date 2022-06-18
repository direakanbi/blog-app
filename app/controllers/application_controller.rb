class ApplicationController < ActionController::Base
  include Turbo::Redirection
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password, :bio) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :surname, :email, :password, :current_password, :bio)
    end
  end

  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to user_session_path, alert: exception.message }
      format.json do
        render json: { message: "Access Denied: #{exception.message}" }, status: 401
      end
    end
  end

  def user_posts_count(user_id)
    Post.where(author_id: user_id).length
  end
end
