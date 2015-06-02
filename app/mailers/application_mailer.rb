class ApplicationMailer < ActionMailer::Base
  default from: "MemryBook <info@memrybook.com>"
  layout 'mailer'

  def signup_confirmation(user)
  	@user = user
  	mail to: user.email, subject: "Welcome to MemryBook"
  end

end
