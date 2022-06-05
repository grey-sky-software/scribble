require 'dotenv/load' unless ENV['HANAMI_ENV'] == 'production'

NOTICE_COLOR = '\033[1;35m'.freeze
NO_COLOR = '\033[0m'.freeze

desc 'Runs all linters'
task :lint do
  system('bundle exec rake lint:style')
  puts "\n"
  system('bundle exec rake lint:smell')
end

namespace :lint do
  desc 'Runs just the style linter'
  task :style do
    puts "\n"
    system("echo '#{NOTICE_COLOR}-----------------------------------------------#{NO_COLOR}'")
    system("echo '#{NOTICE_COLOR}LINTING STYLES WITH RUBOCOP#{NO_COLOR}'")
    system("echo '#{NOTICE_COLOR}-----------------------------------------------#{NO_COLOR}'")
    puts "\n"
    system('rubocop --require rubocop-airbnb')
  end

  desc 'Runs just the code smell linter'
  task :smell do
    puts "\n"
    system("echo '#{NOTICE_COLOR}-----------------------------------------------#{NO_COLOR}'")
    system("echo '#{NOTICE_COLOR}LINTING SMELLS WITH REEK#{NO_COLOR}'")
    system("echo '#{NOTICE_COLOR}-----------------------------------------------#{NO_COLOR}'")
    puts "\n"
    system('reek')
  end
end
