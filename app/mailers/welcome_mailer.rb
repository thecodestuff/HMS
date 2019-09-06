class WelcomeMailer < ApplicationMailer

  def welcome_email(user)
    @reciptent = user
    mail(to: @reciptent.email, subject: 'Welcome on board')
  end
end
