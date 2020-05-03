class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: ENV["PERSONAL_MAIL"], subject: "Phrase.lib 問い合わせ通知"
  end
end
