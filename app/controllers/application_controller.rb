class ApplicationController < ActionController::Base
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
end
