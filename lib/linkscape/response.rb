module Linkscape
  class Response
    require 'rubygems'
    require 'json'

    attr_accessor :request, :response, :data, :valid

    def initialize(request, response)
      @valid = false
      @request = request
      @response = response
      if Net::HTTPSuccess === response
        @data = JSON.parse(response.body).symbolize_keys
        @valid = true
      end
    end
    
    def [](key)
      @data[key.to_sym]
    end

    def inspect
      #<Linkscape::Response:0x10161d8a0 @response=#<Net::HTTPUnauthorized 401 Unauthorized readbody=true>>
      %Q[#<#{self.class} @response=#{@response.class.inspect} @request="#{@request.requestURL}">]
    end

  end
  
end
