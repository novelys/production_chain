namespace :db do
  desc "Dump schema and data to a bzip file"
  task :backup => :environment do
    type, database, user, password, host = retrieve_db_info ENV['FILE']
    send("backup_#{type}_database", database, user, password, host)
  end

  desc "Load schema and data from a bzip file"
  task :restore => :environment do
    type, database, user, password, host = retrieve_db_info ENV['FILE']
    if type == "mongodb"
      send("restore_#{type}_database", database, user, password, host)
    else
      send("drop_#{type}_database", database, user, password, host)
      send("create_#{type}_database", database, user, password, host)
      send("restore_#{type}_database", database, user, password, host)
      
      Rake::Task['db:migrate'].invoke
    end
  end
end

private
  
  def retrieve_db_info(filename)
    filename ||= "database"
    result = File.read "#{Rails.root}/config/#{filename}.yml"
    # result.strip!
    config_file = YAML::load(ERB.new(result).result)
    type = filename == "mongoid" ? "mongodb" : config_file[Rails.env]['adapter']
    return [
      type,
      config_file[Rails.env]['database'],
      config_file[Rails.env]['username'],
      config_file[Rails.env]['password'],
      config_file[Rails.env]['host'] || "127.0.0.1"
    ]
  end
  
  def archive_name
    archive = "#{Rails.root}/db/dump.tar.gz"
  end

  def backup_mysql_database database, user, password, host
    cmd = "/usr/bin/env mysqldump --opt --skip-add-locks -h #{host} -u #{user} "
    puts cmd + "... [password filtered]"
    cmd << " -p'#{password}' " unless password.nil?
    cmd << " #{database} > dump.sql && tar czfh #{archive_name} dump.sql"
    
    system(cmd)
  end

  def restore_mysql_database database, user, password, host
    cmd = "tar xvzf #{archive_name} && "
    cmd << "/usr/bin/env mysql -h #{host} -u #{user} #{database}"
    puts cmd + "... [password filtered]"
    cmd << " -p'#{password}'" unless password.nil?
    cmd << " < dump.sql"
    
    system(cmd)
  end
  
  # pg_dump does not allow to pass the password in the command line for security reasons.
  # You need to define the password for your user in ~/.pgpass
  # See : http://www.postgresql.org/docs/8.1/interactive/libpq-pgpass.html
  #
  # pg_dump -Fc option outputs a custom dump file which is compressed by default.
  # See man pg_dump for more information.
  #
  def backup_postgresql_database database, user, password, host
    cmd = "/usr/bin/env pg_dump -Fc -h #{host} -U #{user} #{database} -f db.dump"
    cmd << " && tar czfh #{archive_name} db.dump"
    puts cmd
    
    system(cmd)
  end

  def restore_postgresql_database database, user, password, host
    cmd = "tar xvzf #{archive_name}"
    cmd << " && /usr/bin/env pg_restore -h #{host} -U #{user} -O -d #{database} db.dump"
    puts cmd
    
    system(cmd)
  end

  def backup_mongodb_database database, user, password, host
    cmd = "rm -rf dump/ 2>/dev/null && /usr/bin/env mongodump -h #{host} -d #{database}"
    cmd << " && tar czfh #{archive_name} dump/"
    
    system(cmd)
  end

  def restore_mongodb_database database, user, password, host
    cmd = "rm -rf dump/ 2>/dev/null && tar xvzf #{archive_name}"
    cmd += " && /usr/bin/env mongorestore -h #{host} -d #{database} --dir dump/*_*"
    puts cmd
    
    system(cmd)
  end

  def drop_mysql_database database, user, password, host
    cmd = "/usr/bin/env mysql -h #{host} -u #{user}"
    cmd << " -e \"DROP DATABASE #{database}\""
    puts cmd + "... [password filtered]"
    cmd << " -p'#{password}'" unless password.nil?
    
    system(cmd)
  end
  
  # We cannot use dropdb command as the rake task seems to lock the database...
  #
  def drop_postgresql_database database, user, password, host
    Rake::Task['db:drop'].invoke
  end
  
  def create_postgresql_database database, user, password, host
    cmd = "/usr/bin/env createdb -h #{host} -U #{user} #{database}"
    puts cmd
    
    system(cmd)
  end

  def create_mysql_database database, user, password, host
    cmd = "/usr/bin/env mysql -h #{host} -u #{user}"
    cmd << " -e \"CREATE DATABASE #{database}\""
    puts cmd + "... [password filtered]"
    cmd << " -p'#{password}'" unless password.nil?
    
    system(cmd)
  end

