module Linkscape
  class Response
    
    class ResponseData
      include Enumerable
      attr_reader :type, :subjects
      def initialize(data, type=nil)
        @data = data
        @type = if type
          type.to_sym
        elsif Hash === @data
          :hash
        elsif Array === @data
          :array
        end
        @data.symbolize_keys! if Hash === @data
        @data.collect{|d|ResponseData.new(d)} if Array === @data
        
        if @type == :hash
          subdatas = {}
          @data.each do |k,v|
            if field = Linkscape::Constants::ResponseFields[k]
              if subject = field[:subject]
                subdatas[subject] ||= {}
                subdatas[subject][field[:key]] = v
              end
            end
          end
          @subjects = []
          subdatas.each do |k,v|
            @data[k] = ResponseData.new(v, k)
            @subjects.push k
          end
        end
        
      end
      def [](key); @data[key.to_sym]; end
      def each(&block); @data.each(&block); end

      def inspect
        #<Linkscape::Response:0x10161d8a0 @response=#<Net::HTTPUnauthorized 401 Unauthorized readbody=true>>
        %Q[#<#{self.class} @type=#{@type.inspect}] + (@subjects ? %Q[ @subjects=#{@subjects.inspect}] : "") + %Q[>]
      end

    end
    
    require 'rubygems'
    require 'json'
    
    attr_accessor :request, :response, :data, :valid
    
    def initialize(request, response)
      @valid = false
      @request = request
      @response = response
      if Net::HTTPSuccess === response
        @data = ResponseData.new(JSON.parse(response.body))
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
