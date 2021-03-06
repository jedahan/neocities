source 'https://rubygems.org'

gem 'sinatra'
gem 'redis'
gem 'redis-namespace'
gem 'sequel', '4.8.0'
gem 'bcrypt'
gem 'sinatra-flash',      require: 'sinatra/flash'
gem 'sinatra-xsendfile',  require: 'sinatra/xsendfile'
gem 'puma',               require: nil
gem 'rack-recaptcha',     require: 'rack/recaptcha'
gem 'rmagick',            require: nil
gem 'sidekiq', '~> 4.1.2'
gem 'ago'
gem 'mail'
gem 'tilt'
gem 'erubis'
gem 'stripe', '1.15.0' #, source: 'https://code.stripe.com/'
#gem 'screencap', '~> 0.1.4'
gem 'cocaine'
gem 'zipruby'
gem 'sass', require: nil
gem 'dav4rack', git: 'https://github.com/planio-gmbh/dav4rack.git', branch: 'redmine-storage'
gem 'filesize'
gem 'thread'
gem 'scrypt'
gem 'rack-cache'
gem 'rest-client', require: 'rest_client'
gem 'addressable', require: 'addressable/uri'
gem 'paypal-recurring', require: 'paypal/recurring'
gem 'geoip'
gem 'io-extra', require: 'io/extra'
gem 'rye'
gem 'base32'
gem 'coveralls', require: false
gem 'sanitize'
gem 'will_paginate'
gem 'simpleidn'
gem 'gandi'
gem 'hoe', '3.14.2', require: nil
gem 'msgpack'
gem 'acme-client'
gem 'http'
gem 'htmlentities'
gem 'rinku'
gem 'image_optim'
gem 'image_optim_pack'
gem 'ipaddress'
gem 'feedjira'
gem 'monetize'

platform :mri, :rbx do
  gem 'magic' # sudo apt-get install file, For OSX: brew install libmagic
  gem 'pg'
  gem 'sequel_pg', require: nil
  gem 'hiredis'
  gem 'posix-spawn'

  group :development, :test do
    gem 'pry'
  end
end

platform :mri do
  group :development, :test do
    gem 'pry-byebug', platform: 'mri'
  end
end

platform :jruby do
  gem 'jruby-openssl'
  gem 'json'
  gem 'jdbc-postgres'

  group :development do
    gem 'ruby-debug', require: nil
  end
end

group :development do
  gem 'shotgun', require: nil
  gem 'certified'
end

group :test do
  gem 'faker'
  gem 'fabrication',           require: 'fabrication'
  gem 'minitest'
  gem 'minitest-reporters',    require: 'minitest/reporters'
  gem 'rack-test',             require: 'rack/test'
  gem 'mocha',                 require: nil
  gem 'rake',                  require: nil
  gem 'poltergeist'
  gem 'capybara_minitest_spec'
  gem 'capybara', '2.10.1',     require: nil
  gem 'rack_session_access',   require: nil
  gem 'webmock',               require: nil
  gem 'stripe-ruby-mock', '2.0.1',      require: 'stripe_mock'
  gem 'timecop'
  gem 'mock_redis'

  platform :mri, :rbx do
    gem 'simplecov',        require: nil
    gem 'm'
  end
end
