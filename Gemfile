source 'https://rubygems.org'
ruby '~>2.5.0'
#ruby=ruby-2.5.1
# Above comment makes rvm stop complaining

gem 'rails', '~> 5.1.2'
# translates from Less CSS to Sass for the Bootstrap framework
gem 'bootstrap-sass',  '3.4.1'
gem 'puma',            '3.9.1'
gem 'sassc-rails'
gem 'uglifier',        '3.2.0'
gem 'coffee-rails',    '4.2.2'
gem 'jquery-rails',    '4.3.1'
gem 'turbolinks',      '5.0.1'
gem 'jbuilder',        '2.7.0'
gem 'bcrypt',          '3.1.11'
gem 'rufus-scheduler', '3.4.2'
gem 'mailgun-ruby',    '1.1.8'
gem 'responders',      '2.4.0'
gem 'coffee-script-source', '1.8.0'
gem 'amazon_wish_miner'
gem 'httparty'
gem 'omniauth-facebook', '5.0.0'
gem 'koala',            '3.0.0'

group :development, :test do
  gem 'dotenv-rails'
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: [:mri, :mingw, :x64_mingw]
  #gem 'bcrypt',       '3.1.11'
  #if this causes problems, uninstall and use below instead
  # gem 'bcrypt-ruby', '3.0.0'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.0.8'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters',       '1.1.9'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
