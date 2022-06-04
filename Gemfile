source 'https://rubygems.org'
ruby '2.7.5'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'pg'
gem 'rack'

group :development do
  gem 'babel-transpiler'
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'reek'
  gem 'rubocop-airbnb'
  gem 'sassc'
  gem 'shotgun', platforms: :ruby
  gem 'uglifier'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
