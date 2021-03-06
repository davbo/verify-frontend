class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  rescue_from StandardError do |exception|
    logger.error(exception)
    render "errors/something_went_wrong"
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
