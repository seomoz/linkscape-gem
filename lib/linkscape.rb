require 'rubygems'
require 'cgi'
require 'base64'
require 'hmac-sha1'
require 'pathname'

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'hash-ext') unless Hash.method_defined?(:symbolize_keys)
require File.join(directory, 'string-ext')

require File.join(directory, 'linkscape', 'signer')
require File.join(directory, 'linkscape', 'constants')

require File.join(directory, 'linkscape', 'client')
require File.join(directory, 'linkscape', 'request')
require File.join(directory, 'linkscape', 'response')
require File.join(directory, 'linkscape', 'errors')
require File.join(directory, 'linkscape', 'middleware', 'gateway_error')

module Linkscape
  def self.root_directory
    Pathname.new File.expand_path('./..', File.dirname(__FILE__))
  end
end
