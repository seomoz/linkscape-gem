module Linkscape
  class Response
    
    class ResponseData
      include Enumerable
      attr_reader :type, :subjects

      class Flags
        def initialize(bitfield, type)
          @value = bitfield
          @flags = Linkscape::Constants::LinkMetrics::ResponseFlags.to_a.collect{|k,vv| k if @value & vv[:flag]}.compact if type == :link
        end
        def [](key); @flags.include? key.to_sym; end
        def to_a; @flags; end
        def to_hash; @flags.inject({}){|h,f|h[f]=true;h}; end
      end

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
        @data = @data.collect{|d|ResponseData.new(d)} if Array === @data
        
        if @type == :hash
          subdatas = {}
          @data.each do |k,v|
            if field = Linkscape::Constants::ResponseFields[k]
              if subject = field[:subject]
                subdatas[subject] ||= {}
                v = ResponseData::Flags.new(v, field[:bitfield]) if field[:bitfield]
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
      def [](*args); Array === @data ? @data[*args] : @data[args.first.to_sym]; end
      def each(&block); @data.each(&block); end
      def each_index(&block); Array === @data ? @data.each_index(&block) : nil; end
      
      def to_s(indent="")
        printer = Proc.new do |h,prefix|
          o = ""
          h.sort{|l,r|l.to_s<=>r.to_s}.each do |k,v|
            field = Linkscape::Constants::ResponseFields[k]
            desc = field ? field[:name] : k.inspect
            o += %Q[#{prefix}#{desc}\t - \t#{field[:bitfield] ? v.to_a.inspect : v}\n]
          end
          o
        end
        if @subjects
          o = ""
          @subjects.each do |s|
            o += %Q[#{indent}#{s}\n]
            o += printer.call(@data[s], "#{indent}  #{s}.")
          end
          o
        else
          printer.call(@data, indent)
        end
      end

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
    
    def [](*args); @data[*args]; end
    def each(&block); @data.each(&block); end
    def each_index(&block); @data.each_index(&block); end
    
    def valid?; valid; end
    
    def inspect
      #<Linkscape::Response:0x10161d8a0 @response=#<Net::HTTPUnauthorized 401 Unauthorized readbody=true>>
      %Q[#<#{self.class} @response=#{@response.class.inspect} @request="#{@request.requestURL}">]
    end
    
  end
  
end
