ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgrid.net',
  :port => '587',
  :authentication => :plain,
  :user_name => ENV["SENDGRID_USERNAME"],
  :password => ENV["SENDGRID_PASSWORD"],
  :domain => 'heroku.com',
  :enable_starttls_auto => true
  
  }
  
  
#heroku config:get SENDGRID_USERNAME
#heroku config:get SENDGRID_PASSWORD