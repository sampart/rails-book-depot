class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :authorize
  rescue_from StandardError, with: :report_error

  def report_error(exception)
    AdministrationMailer.exception(exception.message).deliver_later
    raise
  end

  # This route is only accessible in the test environment
  # But, to be extra sure, check the env again
  def raise_error
    raise(StandardError, "test") if Rails.env.test?
  end

  protected

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
          "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def authorize
    respond_to do |format|
      format.html do
        unless session[:user_id] == SessionsController::SETUP_USER_ID || User.find_by(id: session[:user_id])
          redirect_to login_url, notice: "Please log in"
        end
      end
      format.all do
        authenticate_or_request_with_http_basic do |username, password|
          User.find_by(name: username)&.authenticate(password)
        end
      end
    end
  end
end
