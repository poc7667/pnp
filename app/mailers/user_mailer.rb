class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm
    end
    def confirm(email)
    @message = "Thank you for confirmation!"
    mail(:to => email, :subject => "Registered")  
    return
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
