# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
#ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  TIMING_SLOT = 5
  # Gems
  #config.gem "capistrano-ext", :lib => "capistrano"
  config.gem "configatron"
  config.gem "calendar_date_select"
  #config.gem "ruby-openid", :lib => "openid"

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  config.time_zone = 'UTC'
  
  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_base_session',
    :secret      => '7389ea9180b15f1495a5e73a69a893311f859ccff1ffd0fa2d7ea25fdf1fa324f280e6ba06e3e5ba612e71298d8fbe7f15fd7da2929c45a9c87fe226d2f77347'
  }
  
  config.active_record.observers = :user_observer
end
CGI::Session.expire_after 1.day
ExceptionNotifier.exception_recipients = %w(vijendrakarkala@gmail.com)
ExceptionNotifier.sender_address = %("santhathi" <vijendrakarkala@gmail.com>)
ExceptionNotifier.email_prefix = "[SANTHATHI_ERROR] "
