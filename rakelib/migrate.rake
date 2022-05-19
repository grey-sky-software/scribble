require 'dotenv/load' unless ENV['HANAMI_ENV'] == 'production'
require 'pathname'

namespace :db do
  desc 'Loads the database from the db/schema.sql file'
  task :load do
    system("psql #{ENV.fetch('DATABASE_URL')} < db/schema.sql")
  end

  desc 'Run any pending migrations on the database and dump the schema'
  task :migrate do
    system('bundle exec hanami db migrate')
    system("pg_dump -s --no-owner --no-privileges --if-exists --clean --create #{ENV.fetch('DATABASE_URL')} > db/schema.sql")

    f = File.open(Pathname.new('db/schema.sql').to_s, 'a')
    Pathname.new('db/migrations').entries.each do |name|
      unless name.directory?
        f.write("INSERT INTO public.schema_migrations (filename) VALUES ('#{name}');\n")
      end
    end
    f.close
  end

  desc 'Prepares the database for use by dropping the current database, re-creating it, loading the schema.sql, and running any migrations'
  task :prepare do
    system('bundle exec rake db:reset')
    system('bundle exec rake db:migrate')
  end

  desc 'Resets the database by dropping the current database, re-creating it, and loading the schema.sql'
  task :reset do
    system('bundle exec hanami db drop')
    system('bundle exec hanami db create')
    system('bundle exec rake db:load')
  end
end
