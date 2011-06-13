##
# A cache that is capable of storing values for only a single session.
module Linkscape
  class SessionCache
    
    def initialize
      @cache = {}
    end
    
    def write(key, value, options = {})
      @cache[key] = value
    end
    
    def read(key)
      @cache[key]
    end
    
    def clear
      @cache = {}
    end
  end
end