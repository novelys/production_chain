if Rails.version >= '3'
  module ProductionChain
    class Railtie < Rails::Railtie
      rake_tasks do
        Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each { |file| load file }
      end
    end
  end
else
  require 'rake'
  Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each { |file| load file }
end
