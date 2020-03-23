class ApplicationMailer < ActionMailer::Base
  default from: (Rails.env == 'production' ? Rails.application.credentials.production[:smtp_user] : 'test@test.com')
  layout 'mailer'
end
