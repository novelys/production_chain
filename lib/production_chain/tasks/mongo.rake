namespace :mongo do 
  desc "Drops the database for the current RAILS_ENV"
  task :drop => :environment do
    MongoMapper.connection.drop_database(MongoMapper.database.name)
  end

  desc "Create the database defined in config/database.yml for the current RAILS_ENV"
  task :seed => :environment do
    Rake::Task["db:seed"].invoke
  end

  desc "Drops and recreates the database"
  task :reset => :environment do
    Rake::Task["mongo:drop"].invoke
    Rake::Task["mongo:seed"].invoke
  end
end
