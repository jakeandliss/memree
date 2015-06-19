class Notifier < ApplicationMailer
  def send_share_notification(entry_shareable)
    @target_user = entry_shareable.user
    @entry = entry_shareable.entry
    @origin_user = @entry.user
    mail to: @target_user.email, subject: "You have a shared entry on MemryBook"
  end
end
