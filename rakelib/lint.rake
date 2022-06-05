require 'dotenv/load' unless ENV['HANAMI_ENV'] == 'production'

namespace :lint do
  desc 'Runs all linters'
  task :all do
    system('rubocop --require rubocop-airbnb')
    system('reek')
  end

  desc 'Runs just the style linter'
  task :style do
    system('rubocop --require rubocop-airbnb')
  end

  desc 'Runs just the code smell linter'
  task :smell do
    system('reek')
  end
end
