require 'active_support/concern'

##
# Provide caching of resources on reads.
module Linkscape::CachedResource
  extend ActiveSupport::Concern
  
  included do
    class << self
      alias_method_chain :find, :read_through_cache
    end
    class_attribute :cache_for
  end
  
  module ClassMethods
    
    ##
    # @return [Integer] The number of seconds the resource should cached.
    # @author Brad Seefeld (brad@urbaninfluence.com)
    def cache_expires_in
      Linkscape.config.cache_for
    end
    
    ##
    # This method is automatically called when a find operation is called. It attempts
    # to perform the find operation using the cache instead of going across the wire. If
    # the resource is found in the cache, that value is used, otherwise, the normal find
    # operation is executed.
    # 
    # @param [] arguments Argumentst that are normally passed to the find method
    # @return [Object] The response
    # @author Brad Seefeld (brad@urbaninfluence.com)
    def find_with_read_through_cache(*arguments)
      key = cache_key(arguments)
      
      Linkscape.config.logger.info "The cache key is #{key}"
      
      result = Linkscape.config.cache.read(key).try(:dup)
      
      unless result
        result = find_without_read_through_cache(*arguments)
        
        # Assuming there is an error, an exception is thrown. Cache away!
        Linkscape.config.cache.write(key, result, :expires_in => self.cache_expires_in)
      end
      
      result
    end
    
  private
    
    def cache_key(args)
      key = name
      args.each {|value|
        if value.is_a? Hash
          key << "/" << expand_hash(value)
        else
          key << "/" << value.to_s
        end
      }      
      key.downcase
    end
    
    def expand_hash(hash)
      str = ""
      hash.each do |k, v|
        if v.is_a? Hash
          str << k.to_s << "/" << expand_hash(v)
        else 
          str << "/" << k.to_s << "/" << v.to_s
        end
      end
      str
    end
  end
end