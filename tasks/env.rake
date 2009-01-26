namespace :env do
  desc "reset your dev environment with default reference datas"
  task :reset => :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['spec:db:fixtures:load'].invoke
  end

  desc "Rebuild with production data"
  task :rebuild_with_production_data => :environment do
    env = Rails.env
    # Recreate database 
    `RAILS_ENV=#{env} rake db:drop db:create`
    # Fetch database data
    `RAILS_ENV=#{env} cap production db:dump_and_restore`
    # Play migrations
    `RAILS_ENV=#{env} rake db:migrate`
    # Fetch assets
    `RAILS_ENV=#{env} cap production assets:dump_and_restore`
  end
end
