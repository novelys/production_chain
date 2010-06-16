namespace :db do  
  # this recipe needs the "mysql tasks" plugin
  desc "Make a dump on the remote production box and restore on the local dev box"
  task :dump_and_restore, :roles => :db, :only => {:primary => true} do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    file_env = ENV['FILE'] || "database"
    run "cd #{current_release} && RAILS_ENV=#{rails_env} FILE=#{file_env} #{rake} db:backup"
    get "#{current_release}/db/dump.tar.gz", "db/dump.tar.gz"
    cmd = "rake RAILS_ENV=#{ ENV['RAILS_ENV'] || "development" } FILE=#{file_env} db:restore"
    puts cmd
    system cmd
  end
end

namespace :assets do  
  desc "Make a dump on the remote production box and restore on the local dev box"
  task :dump_and_restore, :roles => :db, :only => {:primary => true} do
    assets_backup_path = "#{current_path}/system.tar.gz"
    run "cd #{current_path}/ && tar czfh #{assets_backup_path} public/system/"
    get "#{assets_backup_path}", "system.tar.gz"
    run "cd #{current_path}/ && rm #{assets_backup_path}"
    `rm -rf public/system/*`
    `tar xvzf system.tar.gz`
  end
end
