module Linkscape
  ##
  # A ActiveSupport::JSON backend
  #
  # @author Jim Deville <james@urbaninfluence.com>
  module JSON
    extend self
    ParseError = ::JSON::ParserError
    ##
    # Attempts to convert the given string to UTF-8, then parses it
    #
    # @param [String] json the json encoded string to convert
    # @return [Object] the decoded object
    def decode(json)
      ::JSON.parse json
    end
  end
end
