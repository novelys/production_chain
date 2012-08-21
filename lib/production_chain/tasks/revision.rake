namespace :revision do
  desc "print revision number in admin template"
  task :print do
    svn_revision = ENV['SVN_REVISION'] || IO.popen("svn info").readlines[4].split(" ").last
    release_number = ENV['RELEASE_NUMBER'] || Dir.pwd.split("/").last
    revision  = RAILS_ENV
    revision += "-r#{svn_revision}"
    revision += "-#{release_number}" if release_number.to_i != 0
  
    path = "app/views/shared/_revision.html.haml"
    `echo "#{revision}" > #{path}`
  end
end