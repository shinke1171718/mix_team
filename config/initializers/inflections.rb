Rails.application.configure do
  unless Rails.env.production?
    config.action_mailer.interceptors = %w[MailInterceptor]
  end
end