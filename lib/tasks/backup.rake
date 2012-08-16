require 's3'

namespace :s3 do

  desc "Backup code, database, and scm to S3"
  task :backup => ["s3:backup:db", "s3:backup:shared"]

  namespace :backup do
    desc "Backup the database to S3"
    task :db do
      db_tmp_path = "#{Rails.root}/db/dump.tar.gz"
      Rake::Task['db:backup'].invoke
      send_to_s3(db_tmp_path)
    end
    
    desc "Backup the shared folder to S3"
    task :shared do
      cmd = " cd .. && tar czfh  /tmp/shared.tar.gz shared/ --exclude=shared/log/* --exclude=shared/sphinx/*"
      system(cmd)
      shared_tmp_path = "/tmp/shared.tar.gz"
      send_to_s3(shared_tmp_path)
    end
  end
end

private

  def conn
    @s3_config ||= YAML.load_file("#{Rails.root}/config/backup_s3.yml")[Rails.env]
    @conn ||= S3::Service.new(:access_key_id => @s3_config['access_key_id'], 
                              :secret_access_key => @s3_config['secret_access_key'],
                              :use_ssl => true)
  end

  def bucket_name
    @s3_config['bucket_name']
  end

  def backup_bucket
    begin
      bucket ||= conn.buckets.find(bucket_name)
    rescue S3::Error::ResponseError
      bucket = conn.buckets.build(bucket_name)
      bucket.save
    end
    bucket
  end

  def send_to_s3 local_file_path
    bucket = backup_bucket
    s3_file_path = Time.now.strftime("%Y%m%d") + '/' + local_file_path.split('/').last

    upload = bucket.objects.build(s3_file_path)
    upload.content = File.open(local_file_path)
    upload.save
  end
