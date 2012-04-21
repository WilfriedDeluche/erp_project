require 'email_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => ENV['EMAIL_SMTP'],
  :password             => ENV['PWD_SMTP'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
} if Rails.env.development?

## smtp_settings still to set up for production environment

ActionMailer::Base.register_interceptor(EMailInterceptor) if Rails.env.development?