class ContactForm < MailForm::Base
  attribute :message
  attribute :name
  attribute :email

  def headers
    {
      :subject => "Feedback from MemryBook User",
      :to => "info@memrybook.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end