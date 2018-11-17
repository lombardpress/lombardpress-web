require 'platform-api'

  task :restart_dyno => :environment do
    puts "task restart_worker is on"
    heroku = PlatformAPI.connect_oauth("e7dd6ad7-3c6a-411e-a2be-c9fe52ac7ed2")
    heroku.dyno.restart_all("lombardpress-web")
  end
