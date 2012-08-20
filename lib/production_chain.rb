if defined?(Rails)
  # Core Ext
  Dir[File.join(File.dirname(__FILE__), 'production_chain/core_ext/**/*.rb')].each { |file| require file }

  # Rails
  require "rails/action_controller/abstract_request"
  require "rails/action_view/text_helper"

  # Rake Tasks
  require "production_chain/tasks"
end
