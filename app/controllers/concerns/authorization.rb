module Authorization 
  extend ActiveSupport::Concern

  class NotAuthorizedError < StandardError; end

  included do
    rescue_from NotAuthorizedError do
      redirect_to products_path, alert: t('common.not_authorized')
    end

    private

    def authorize!(record = nil) 
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
      raise NotAuthorizedError unless is_allowed 
    end 
  end
end