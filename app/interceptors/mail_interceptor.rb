class MailInterceptor
  def self.delivering_email(message)
    message.to = ENV['TEST_NOTICE_MAIL']
  end
end