class ApplicationController < ActionController::Base
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

  def authorize
    unless session[:user_id] == SessionsController::SETUP_USER_ID || User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
