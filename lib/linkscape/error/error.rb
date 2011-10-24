##
# Error thrown by Gem methods
#
# @author Jim Deville (james@urbaninfluence.com)
class Linkscape::Error::Error < StandardError
  ##
  # Wraps an exception in a Linkscape::Error::Error
  #
  # @param [Exception] ex exception to be wrapped
  # @param [String] msg (ex.message) new description of error
  def self.wrap(ex, msg = ex.message)
    obj = new msg
    obj.inner = ex
    obj
  end

  ##
  # Accessor to access the wrapped exception
  #
  # @return [Exception] the exception
  attr_accessor :inner
end
