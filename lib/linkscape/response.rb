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
        @data = JSON.parse(response.body)
        @data.symbolize_keys! if Hash === @data
        @data.each{|v|v.symbolize_keys! if Hash === v} if Array === @data
        @valid = true
      end
    end
    
    def [](key)
      @data[key.to_sym]
    end
    
    def valid?; valid; end

    def inspect
      #<Linkscape::Response:0x10161d8a0 @response=#<Net::HTTPUnauthorized 401 Unauthorized readbody=true>>
      %Q[#<#{self.class} @response=#{@response.class.inspect} @request="#{@request.requestURL}">]
    end

  end
  
end
