class ApplicationMailer < ActionMailer::Base
  default from: "mail@memrybook.com"
  default_url_options[:host] = "MemryBook"
  layout 'mailer'
end
