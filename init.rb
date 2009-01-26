Dir[File.join(File.dirname(__FILE__), 'lib/*.rb')].each { |file| load file }
require "core_ext/string"
require "core_ext/object"