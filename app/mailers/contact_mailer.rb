class ContactMailer < ApplicationMailer
  def send_email(user, instag)
    @user = user
    @instag = instag
    mail to: @user.email, subject: "投稿完了しました"
  end
end
