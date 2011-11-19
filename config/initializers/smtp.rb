if settings = Setting.s('smtp.settings')
  ActionMailer::Base.smtp_settings = JSON.parse(settings)
  ActionMailer::Base.delivery_method = :smtp
elsif Setting.s('sendgrid.username')
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => Setting.s('sendgrid.username'),
    :password       => Setting.s('sendgrid.password'),
    :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method = :smtp
end
