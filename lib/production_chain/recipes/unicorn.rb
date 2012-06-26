## Usual unicorn configuration.

# Config
_cset :unicorn_binary, 'bundle exec unicorn_rails'
_cset :unicorn_config, "#{current_path}/config/unicorn.rb"
_cset :unicorn_pid,    "#{current_path}/tmp/pids/unicorn.pid"

# Tasks
namespace :deploy do
  common_options = {
    :roles  => :app,
    :except => {:no_release => true}
  }

  desc 'Start unicorn'
  task :start, common_options do
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end

  desc 'Stop unicorn'
  task :stop, common_options do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end

  desc 'Gracefully stop unicorn'
  task :graceful_stop, common_options do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end

  desc 'Reload unicorn'
  task :reload, common_options do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end

  desc 'Restart unicorn'
  task :restart, common_options do
    stop
    start
  end
end
