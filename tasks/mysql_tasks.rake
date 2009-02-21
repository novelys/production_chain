namespace :db do
  namespace :mysql do
    desc "Dump schema and data to an SQL file (/db/backup_YYYY_MM_DD.sql)"
    task :backup => :environment do
      current_date = Time.now.strftime("%Y_%m_%d")
      archive = "#{RAILS_ROOT}/db/dump.sql.bz2"
      database, user, password = retrieve_db_info
    
      cmd = "/usr/bin/env mysqldump --opt --skip-add-locks -u#{user} "
      puts cmd + "... [password filtered]"
      cmd += " -p'#{password}' " unless password.nil?
      cmd += " #{database} | bzip2 -c > #{archive}"
      system(cmd)
    end
  
    desc "Load schema and data from an SQL file (/db/restore.sql)"
    task :restore => :environment do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke

      archive = "#{RAILS_ROOT}/db/dump.sql.bz2"
      database, user, password = retrieve_db_info
      cmd = "bunzip2 < #{archive} | "
      cmd += "/usr/bin/env mysql -u #{user} #{database}"
      puts cmd + "... [password filtered]"
      cmd += " -p'#{password}'" unless password.nil?
      system(cmd)

      Rake::Task['db:migrate'].invoke
    end
  end
end

  private
  def retrieve_db_info
    result = File.read "#{RAILS_ROOT}/config/database.yml"
    result.strip!
    config_file = YAML::load(ERB.new(result).result)
    return [
      config_file[RAILS_ENV]['database'],
      config_file[RAILS_ENV]['username'],
      config_file[RAILS_ENV]['password']
    ]
  end
  
  def mysql_execute(username, password, sql)
    system("/usr/bin/env mysql -u #{username} -p'#{password}' --execute=\"#{sql}\"")
  end
