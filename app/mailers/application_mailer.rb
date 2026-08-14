class ApplicationMailer < ActionMailer::Base
  default from: ENV['ACTION_MAILER_USER']
  layout "mailer"
end
