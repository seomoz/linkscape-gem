module Linkscape
  class Request
    require 'net/http'
    require 'uri'
    require 'cgi'
    # require 'base64'
    # require 'rubygems'
    # require 'hmac-sha1'
    
    attr_accessor :requestURL
    
    URL_TEMPLATE = %Q[http://:apiHost:/:apiRoot:/:api:/:url:?AccessID=:accessID:&Expires=:expiration:&Signature=:signature:]

    def self.run(options)
      self.new(options).run
    end
    
    def initialize(options)
      url = CGI::escape(options[:url].sub(/^https?:\/\//, ''))
      @requestURL = URL_TEMPLATE.template(signRequest(options.merge(:url => url)))
      @requestURL += "&" + options[:query].collect{|k,v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}"}.join('&') if options[:query] && Hash === options[:query]
      @requestURL += "&" + options[:query] if options[:query] && String === options[:query]

      options[:offset] = 0 if options[:offset] && options[:offset] < 0
      @requestURL += "&Offset=#{options[:offset]}" if options[:offset]

      options[:limit] = 1000 if options[:limit] && options[:limit] > 1000
      @requestURL += "&Limit=#{options[:limit]}" if options[:limit]
    end
    
    def run
      res = fetch(URI.parse(@requestURL))
      # res = fetch(URI.parse('http://martian.at/other/ose.json'))
      return Response.new(self, res)
    end

    def inspect
      #<Linkscape::Request:0x1016228a0 @requestURL="http://lsapi.seomoz.com/linkscape/mozrank/www.martian.at%2F?AccessID=ose&Expires=1258772331&Signature=Hfwssn0ZbWMe9MEf6%2FWoHOGFHzQ%3D">
      %Q[#<#{self.class}="#{@requestURL}">]
    end

    private
    def signRequest options
      Linkscape::Signer.signParams(options)
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
end
