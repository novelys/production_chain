if defined?(Rails)
  # Core Ext
  require "core_ext/numeric"

  # Rails
  require "rails/action_controller/abstract_request"
  require "rails/action_view/text_helper"

  # Rake Tasks
  require "tasks"
end
