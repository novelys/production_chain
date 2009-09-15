Dir[File.join(File.dirname(__FILE__), 'lib/*.rb')].each { |file| load file }
require "core_ext/object"
require "core_ext/numeric"
require "core_ext/string"
