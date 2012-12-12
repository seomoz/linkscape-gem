require 'forwardable'
module Linkscape
  class Response
    extend Forwardable
    
    class ResponseData
      include Enumerable
      extend Forwardable
      
      attr_reader :type, :subjects

      class Flags
        attr_reader :value
        def initialize(bitfield, type)
          @value = bitfield
          @flags = Linkscape::Constants::LinkMetrics::ResponseFlags.to_a.collect{|k,vv| k if (@value & vv[:flag]) == vv[:flag]}.compact if type == :link
          @flags = Linkscape::Constants::AnchorMetrics::ResponseFlags.to_a.collect{|k,vv| k if (@value & vv[:flag]) == vv[:flag]}.compact if type == :anchor
        end
        def [](key); @flags.include? key.to_sym; end
        def to_a; @flags; end
        def to_hash; @flags.inject({}){|h,f|h[f]=true;h}; end
        def to_s
          %Q[#{@value}=#{self.to_a.inspect}]
        end
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
        
        if Hash === @data && !type.nil?
          Linkscape::Constants::CalculationKeyMap.each do |key, keys|
            unless @data[keys[0]].nil? or @data[keys[1]].nil?
              @data[key] = @data[keys[0]] - @data[keys[1]]
            end
          end
        end
        
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

      def_delegators :@data, :length, :each, :each_index, :map, :collect, :select, :keys
      def [](*args)
        if Array === @data
          @data[*args]
        else
          k = args.first.to_sym
          if @subjects && @subjects.length == 1 && @data[@subjects.first][k]
            @data[@subjects.first][k]
          else
            @data[args.first.to_sym]
          end
        end
      rescue
        nil
      end
      
      def to_s(indent="")
        printer = Proc.new do |h,prefix|
          o = ""
          h.sort{|l,r|l[0].to_s<=>r[0].to_s}.each do |k,v|
            v = v.to_s
            o += %Q[%s%-#{Linkscape::Constants::LongestKeyLength+5}.#{Linkscape::Constants::LongestKeyLength+5}s - %s\n] % [prefix, k, v]
          end
          o
        end
        if type == :array
          o = ""
          @data.each_with_index do |d,idx|
            o += %Q[#{indent}[#{idx}]\n] + d.to_s("#{indent}  ") + "\n"
          end
          o
        elsif @subjects
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
      if response.success?
        @data = ResponseData.new(JSON.parse(response.body))
        @valid = true
      end
    end
    
    def_delegators :@data, :[], :length, :each, :each_index, :map, :collect, :select
    
    def valid?; valid; end
    
    def inspect
      #<Linkscape::Response:0x10161d8a0 @response=#<Net::HTTPUnauthorized 401 Unauthorized readbody=true>>
      %Q[#<#{self.class} @response.status=#{@response.status} @request="#{@request.requestURL}">]
    end
    
  end
  
end
