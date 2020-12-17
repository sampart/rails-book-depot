class AdministrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.administration_mailer.exception.subject
  #
  def exception(exception)
    @exception = exception

    # TODO specify in config?
    # Machine-specific config?
    mail to: "sampart@github.com"
  end
end
