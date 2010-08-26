# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

EASY_AUTH_SALT = "714f5c99be4335b3bcff4a94a304c7d1737610f162e6679dbcbbaf82dc9"+
                 "77543993e0a88411c22a17726a60a1bf6bbaec8789ae84c9ae896d5ac79"+
                 "4845a0d575"

ENV['RECAPTCHA_PUBLIC_KEY']  = '6Leb4QgAAAAAAHAjPAKH6Ghzmsbx3RiY0iF5oBJq'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6Leb4QgAAAAAAMvxOD0JOSZLMAntGlOWf4dCtuBr'

Rails::Initializer.run do |config|
  config.time_zone = 'Amsterdam'
end
