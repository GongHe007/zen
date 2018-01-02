source 'https://gems.ruby-china.org/'

gem 'dotenv-rails'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'rails', '~> 5.1.4'
gem 'sqlite3'
gem 'mysql2', "~> 0.4.0"
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'will_paginate', '~> 3.1.0'
gem 'redis', '~> 3.3.3'
gem 'sidekiq', '~> 5.0.3'
gem 'ethereum'
gem 'haml', '~> 5.0.4'

group :development, :test do
  gem 'pry'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', '~> 3.9'
  gem 'capistrano-rails', "~> 1.3.0"
  gem 'capistrano-rvm', "~> 0.1.2"
  gem 'capistrano3-puma', "~> 3.1.1"
  gem 'capistrano-sidekiq', "~> 0.20.0"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
