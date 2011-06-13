require "logger"
require "linkscape/session_cache"

module Linkscape
  class Configuration
    attr_accessor :cache, :logger, :access_id, :access_key, :cache_for
    
    def initialize
      self.cache = Linkscape::SessionCache.new
      self.cache_for = 60
      self.logger = Logger.new(STDOUT)
    end
  end
end