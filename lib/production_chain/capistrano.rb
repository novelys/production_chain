require 'capistrano'

if Capistrano::Configuration.instance
  Capistrano::Configuration.instance.load_paths << File.dirname(__FILE__)
  Capistrano::Configuration.instance.load 'recipes/default'
  Capistrano::Configuration.instance.load 'recipes/dump_and_restore'
end