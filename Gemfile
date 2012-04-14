require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'
gem 'rails', '3.1.4'
gem 'sqlite3'
group :production do
  gem 'mysql2'
  gem 'cloudfoundry-jquery-rails'
  gem 'postmark'
  gem 'postmark', :git => 'git://github.com/langalex/postmark-rails.git'
end
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end
group :development do
  gem 'jquery-rails'
end
gem "twitter-bootstrap-rails", ">= 2.0.3", :group => :assets 
group :test do
  gem 'turn', '0.8.2', :require => false
end
gem "rspec-rails", ">= 2.9.0.rc2", :group => [:development, :test]
gem "factory_girl_rails", ">= 3.1.0", :group => [:development, :test]
gem "email_spec", ">= 1.2.1", :group => :test
gem "guard", ">= 0.6.2", :group => :development
case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end
gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-rails", ">= 0.0.3", :group => :development
gem "guard-livereload", ">= 0.3.0", :group => :development
gem "guard-rspec", ">= 0.4.3", :group => :development
gem "devise", ">= 2.1.0.rc"
gem "devise_invitable", ">= 1.0.1"
gem "cancan", ">= 1.6.7"
gem "rolify", ">= 3.1.0"
gem "simple_form"
gem "rails-footnotes", ">= 3.7", :group => :development
gem "will_paginate", ">= 3.0.3"

# realtime hackathon
gem "nifty-generators"
gem "pusher"
gem "twilio"


gem 'bunny'
gem 'json'
