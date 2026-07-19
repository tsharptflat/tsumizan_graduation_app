class ContactMailer < ApplicationMailer
  default from: "積み算 <hogehoge@example.com>"

  def contact_mail(contact)
    @contact = contact
    mail to: contact[:email], bcc: ENV["ACTION_MAILER_USER"], subject: "[自動送信]お問い合わせについて"
  end
end