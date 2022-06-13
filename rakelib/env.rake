namespace :env do
  namespace :dev do
    desc 'Sets up the environment variables defined in the .env.development file'
    task :setup do
      system("export $(cat docker/.env.development | xargs)")
    end
  end

  namespace :test do
    desc 'Sets up the environment variables defined in the .env.test file'
    task :setup do
      system("export $(cat docker/.env.test | xargs)")
    end
  end
end
