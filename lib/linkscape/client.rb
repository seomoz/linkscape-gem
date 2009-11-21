module Linkscape
  class Client
    def initialize(*args)
      options = Hash === args.last ? args.pop : {}
      @accessID = args.first ? args.shift : (options[:id] || options[:ID] || options[:accessID])
      @secretKey = args.first ? args.shift : (options[:secret] || options[:secretKey] || options[:key])
      
      @options = {
        :apiHost => 'lsapi.seomoz.com',
        :apiRoot => 'linkscape',
        :accessID => @accessID,
        :secretKey => @secretKey
      }.merge(options)
      
    end

    def mozRank(*args)
      options = Hash === args.last ? args.pop : {}
      url = args.first ? args.shift : options[:url]

      raise MissingArgument, "mozRank requires a url." unless url

      options[:url] = url
      options[:api] = 'mozrank'

      Linkscape::Request.run(@options.merge(options))
    end
    
    def urlMetrics(*args)
      options = Hash === args.last ? args.pop : {}
      url = args.first ? args.shift : options[:url]

      raise MissingArgument, "urlMetrics requires a url." unless url

      options[:url] = url
      options[:api] = 'url-metrics'

      options[:query] = {
        'Cols' => translateBitfield(options[:cols], options[:columns], options[:fields], :type => :url)
      }
      
      Linkscape::Request.run(@options.merge(options))
    end
    
    def linkMetrics(*args)
      options = Hash === args.last ? args.pop : {}
      whichSet = args.first ? args.shift.to_sym : options[:set]
      url = args.first ? args.shift : options[:url]
      
      raise MissingArgument, "linkMetrics requires a set (:page, :subdomain, :domain) and a url." unless whichSet and url
      
      options[:url] = url

      options[:api] = {
        :page => 'page-linklist',
        :subdomain => 'subdomain-linklist',
        :domain => 'domain-linklist',
      }[whichSet]
      
      raise InvalidArgument, "linkMetrics set must be one of :page, :subdomain, :domain" unless options[:api]
      
      options[:query] = {
        'SourceCols' => translateBitfield(options[:cols], options[:columns], options[:fields], :type => :url),
        'TargetCols' => translateBitfield(options[:cols], options[:columns], options[:fields], :type => :url),
        'LinkCols' => translateBitfield(options[:cols], options[:columns], options[:fields], :type => :link),
      }
      
      Linkscape::Request.run(@options.merge(options))
    end
    
    def inspect
      %Q[#<#{self.class}:#{"0x%x" % self.object_id} api="#{@options[:apiHost]}/#{@options[:apiRoot]}" accessID="#{@options[:accessID]}">]
    end
    
    private
    
    def translateBitfield *columns
      options = Hash === columns.last ? columns.pop : {}

      columns.flatten!
      columns.compact!

      bits = columns.inject(0) do |bitfield, key|
        requestBit = 
          if options[:type] == :url
            Linkscape::Constants::URLMetrics::RequestBits[key]
          elsif options[:type] == :link
            Linkscape::Constants::LinkMetrics::RequestBits[key]
          else
            Linkscape::Constants::URLMetrics::RequestBits[key] || Linkscape::Constants::LinkMetrics::RequestBits[key]
          end
        raise InvalidArgument, "Unknown #{options[:type]} flag '#{key.inspect}'".gsub(/  +/, ' ') unless requestBit
        bitfield |= requestBit[:flag]
      end
      
      bits
    end
    
  end
end
