if defined?(Rails)
  # Core Ext
  require "core_ext/numeric"

  # Rails
  require "rails/action_controller/abstract_request"
  require "rails/action_view/text_helper"

  # Rake Tasks
  require "tasks"
end

if defined?(Capistrano)
  # Recipes
  Dir[File.join(File.dirname(__FILE__), 'recipes/**/*.rb')].each { |file| load file }
end