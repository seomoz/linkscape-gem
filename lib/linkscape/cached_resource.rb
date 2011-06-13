require 'active_support/concern'

##
# Provide caching of resources on reads. Hooks into Rails.cache and automatically caches
# remote data.
module Linkscape::CachedResource
  extend ActiveSupport::Concern
  
  included do
    class << self
      alias_method_chain :find, :read_through_cache
    end
    class_attribute :cache_for
  end
  
  module ClassMethods
    def cache_expires_in
      Linkscape.config.cache_for
    end
    
    def find_with_read_through_cache(*arguments)
      key = cache_key(arguments)
      result = Linkscape.config.cache.read(key).try(:dup)
      
      unless result
        result = find_without_read_through_cache(*arguments)
        
        # TODO is result an error?
        
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