
require "greased/loggable"

module Greased
  extend Loggable
    
  def self.load_yaml(filename, options = {})
    # allow multiple filenames and use the first one that exists
    filename = Array.wrap(filename).find do |path|
      File.exists?(path).tap do |found|
        #logger.debug "#{self.class}.#{__method__} exists [#{found}]: #{path}"
      end
    end
    
    unless filename.nil?
      source  = File.read(filename)
      source  = ERB.new(source).result unless options[:skip_erb]
      all     = YAML.load(source)
    end
    
    all || {}
  end
  
  def self.file_path(*args)
    path = File.expand_path File.join(*args)
    path = File.realpath(path) if File.exists?(path)
    
    #logger.debug "#{self.class}.#{__method__} path: #{path}"
    
    path
  end
end

require "greased/applicator"
require "greased/options"
require "greased/method_caller"
require "greased/setting"
require "greased/settings"

require "greased/rails" if defined? ::Rails
