require 'active_resource/exceptions'
module Linkscape
  extend self
  module Error end

  ##
  # Wraps StandardError and ActiveResource::ConnectionErrors in custom errors
  # in order to filter them out
  #
  # @param [Block] blk Block to execute/wrap
  # @author Jim Deville (james@urbaninfluence.com)
  # @return result of the block
  def wrap_errors &blk
    yield
  rescue Linkscape::Error::Error, Linkscape::Error::LinkscapeError => e
    raise e
  rescue ActiveResource::ConnectionError => e
    raise Linkscape::Error::LinkscapeError.wrap e
  rescue StandardError => e
    raise Linkscape::Error::Error.wrap e
  end
end
require 'linkscape/error/error'
require 'linkscape/error/linkscape_error'

