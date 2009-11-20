class String
  def template v={}, delim=':'
    v = v.inject({}) { |options, (key, value)| options[key.to_s] = value; options }
    re = Regexp.new("#{delim}([a-zA-Z][a-zA-Z0-9_]*)#{delim}")
    self.gsub(re) {|m| v[$1].to_s }
  end
end

module Linkscape
  class Client
    def initialize(*args)
      options = Hash === args.last ? args.pop : {}
      @accessID = args.empty? ? args.shift : (options[:id] || options[:ID] || options[:accessID])
      @secretKey = args.empty? ? args.shift : (options[:secret] || options[:secretKey] || options[:key])
      
      @options = {
        :apiHost => 'lsapi.seomoz.com',
        :apiRoot => 'linkscape'
      }.merge(options)
      
    end

    def mozRank(*args)
      options = Hash === args.last ? args.pop : {}
      url = args.empty? ? args.shift : options[:url]
      
      Linkscape::Request.new(@options.merge(options).merge({:api => 'mozrank', :url => url})).run
    end
    
    # need to be able to use free mozrank api
    # need to be able to use non-free apis
    # need to be able to pass symbol/string arrays/hashes of fields desired
    # need to get back hashes (with indifferent access) of results.
    
  end
  
  class Request
    require 'net/http'
    require 'uri'
    
    URL_TEMPLATE = %Q[http://:apiHost:/:apiRoot:/:api:/:url:?AccessID=:accessID:&Expires=:expires:&Signature=:signature:]
    
    def initialize(options)
      url = URI.escape(options[:url].sub(/^https?:\/\//, ''))
      @requestURL = URL_TEMPLATE.template(options.merge(
                      :url => url
                    ))
    end
    
    def run
      res = fetch(URI.parse(@requestURL))
      return Response.new(self, res)
    end

    def signRequest
    end

    class RecursionError < StandardError; end
    class AuthenticationError < StandardError; end
    
    private
    def fetch(uri, limit = 10)
      # You should choose better exception.
      raise RecursionError, 'HTTP redirect too deep' if limit == 0

      response = Net::HTTP.get_response(uri)
      case response
      when Net::HTTPSuccess     then response
      when Net::HTTPRedirection then fetch(response['location'], limit - 1)
      else
        response.error!
      end
    end

  end
  
  class Response
    def initialize(request, response)
    end
  end
  
end