class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "per_ik@outlook.com", subject: "Phrase.lib 問い合わせ通知"
  end
end
