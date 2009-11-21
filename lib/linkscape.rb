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
      puts @options.inspect
      puts options.inspect
      puts url.inspect
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
    require 'base64'
    require 'cgi'
    require 'rubygems'
    require 'hmac-sha1'
    
    URL_TEMPLATE = %Q[http://:apiHost:/:apiRoot:/:api:/:url:?AccessID=:accessID:&Expires=:expiration:&Signature=:signature:]
    
    def initialize(options)
      puts options.inspect
      url = CGI::escape(options[:url].sub(/^https?:\/\//, ''))
      @requestURL = URL_TEMPLATE.template(signRequest(options.merge(:url => url)))
    end
    
    def run
      # return @requestURL
      res = fetch(URI.parse(@requestURL))
      return Response.new(self, res)
    end

    class RecursionError < StandardError; end
    class AuthenticationError < StandardError; end
    
    private
    def signRequest options
      id = options[:accessID]#CGI::escape(options[:accessID])
      expiration = Time.now.to_i + 600
      key = options[:secretKey]#CGI::escape(options[:secretKey])
      signature = CGI::escape(
                    Base64.encode64(
                      HMAC::SHA1.digest(
                        key,
                        "#{id}\n#{expiration}"
                      )
                    ).chomp
                  )
      options[:expiration] = expiration
      options[:signature] = signature
      puts options.inspect
      options
    end

    def fetch(uri, limit = 10)
      # You should choose better exception.
      raise RecursionError, 'HTTP redirect too deep' if limit == 0

      response = Net::HTTP.get_response(uri)

      return fetch(response['location'], limit - 1) if Net::HTTPSuccess == response

      response
    end

  end
  
  class Response
    attr_accessor :request, :response

    def initialize(request, response)
      @request = request
      @response = response
    end
  end
  
end