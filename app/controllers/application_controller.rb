class ApplicationController < ActionController::Base
  include Pagy::Backend

  class NotAuthorizedError < StandardError; end
  
  rescue_from NotAuthorizedError do
    redirect_to products_path, alert: 'You are not allowed to do that'
  end

  before_action :set_current_user
  before_action :protect_pages

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    redirect_to new_session_path, alert: 'You have to login or create an account' unless Current.user
  end

  def authorize!(record = nil) 
    is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
    raise NotAuthorizedError unless is_allowed 
  end 
end
