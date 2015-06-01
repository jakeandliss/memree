source 'https://rubygems.org'
#ruby '2.2.0'

gem 'sprockets-rails', :require => 'sprockets/railtie'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use Unicorn as the app server
# gem 'unicorn' 
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem "nokogiri"
gem 'aws-sdk', '< 2.0'
gem "figaro"
gem 'foundation-rails'
gem "jquery-slick-rails"
gem "paperclip", "~> 4.2"
gem 'paperclip-av-transcoder'
gem 'delayed_job_active_record'
gem "daemons"
gem 'delayed_paperclip'
gem 'paperclip-compression'
gem 'truncate_html'
gem "font-awesome-rails"
gem 'jQuery-Validation-Engine-rails'
gem 'devise'
gem 'will_paginate'
# heroku
#gem 'rails_12factor', group: :production
gem 'pg'
gem 'thin'
gem 'ancestry'
gem 'magnific-popup-rails'
gem 'client_side_validations', github: "DavyJonesLocker/client_side_validations", branch: "4-2-stable"


group :assets do

end

group :production do
  gem "unicorn-rails"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'capistrano-unicorn', :require => false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring',  '~> 1.3.5'
  gem 'rspec-rails', '~> 3.2.1'
  gem 'capybara', '~> 2.4.4'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem "factory_girl_rails", "~> 4.0"
  gem 'quiet_assets'
  gem 'capistrano'
  gem 'rvm-capistrano',  require: false
end

group :test do
  gem 'capybara-email', "~> 2.4.0"
end