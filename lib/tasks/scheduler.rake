require 'platform-api'

  task :restart_dyno => :environment do
    puts "task restart_worker is on"
    heroku = PlatformAPI.connect_oauth(ENV['HEROKU_OAUTH'])
    heroku.dyno.restart_all("lombardpress-web")

  end
