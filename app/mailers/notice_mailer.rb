class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  def sendmail_blog(blog)
      @blog = blog

      mail to: "r9.life.is.art.21m@gmail.com",
         subject: '【Achieve】ブログが投稿されました'

      mail to: "to@example.org"
  end

  def sendmail_contact(contact)
    @contact = contact

    mail to: "user.email",
         subject: 'お問い合わせが完了しました！'
  end
end
