class EMailInterceptor
  def self.delivering_email(message)
    message.subject = "[#{message.to}] #{message.subject}"
    if ENV['EMAIL'] # set this in your ~/.bashrc or your ~/.zshrc
      message.to = "#{ENV['EMAIL']}"
    else
      message.to = "wilfried.deluche@gmail.com" # do not change this. If you don't receive emails then there is a problem with your environment variable "EMAIL"
    end
  end
end