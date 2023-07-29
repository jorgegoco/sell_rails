class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current_user
  before_action :protect_pages

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    redirect_to new_session_path, alert: 'You have to login or create an account' unless Current.user
  end
end
