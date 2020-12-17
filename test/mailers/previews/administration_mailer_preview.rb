# Preview all emails at http://localhost:3000/rails/mailers/administration_mailer
class AdministrationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/administration_mailer/exception
  def exception
    AdministrationMailer.exception
  end

end
