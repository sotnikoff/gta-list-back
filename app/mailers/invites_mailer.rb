class InvitesMailer < ApplicationMailer
  def invite(user, url)
    @url = url
    @user = user
    mail(to: user.email, subject: 'You were invited')
  end
end
