class ApplicationMailer < ActionMailer::Base
  default from: "info@journally.com"
  default_url_options[:host] = "localhost:3000"
  layout 'mailer'
end
