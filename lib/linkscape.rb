require 'linkscape/configuration'
require 'linkscape/link'
require 'linkscape/anchor'
require 'linkscape/page'
require 'linkscape/url_metric'
require 'linkscape/fields'
require 'linkscape/signer'

#require File.join(directory, 'hash-ext') unless Hash.method_defined?(:symbolize_keys)


module Linkscape
  
  def self.config
    @config ||= Configuration.new
  end
  
  def self.configure
    yield config
    
    Linkscape::Resource.user = config.access_id
    Linkscape::Resource.password = config.access_key
  end
end
