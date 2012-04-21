class EMailInterceptor
  def self.delivering_email(message)
    message.subject = "[#{message.to}] #{message.subject}"
    message.to = "#{ENV['EMAIL']}" if ENV['EMAIL']
  end
end