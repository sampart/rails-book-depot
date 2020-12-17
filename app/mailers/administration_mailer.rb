class AdministrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.administration_mailer.exception.subject
  #
  def exception(exception_message)
    @exception = exception_message

    mail to: "sampart@github.com", subject: "Application exception"
  end
end
