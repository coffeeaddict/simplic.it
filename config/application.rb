require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'couchrest_model'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Webapp
  class Application < Rails::Application
    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{Rails.root}/lib)
    
    config.time_zone = 'UTC'
    config.i18n.default_locale = :en
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end
