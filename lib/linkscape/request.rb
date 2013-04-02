module Linkscape
  class Request
    require 'faraday'
    require 'faraday_middleware'
    require 'uri'
    require 'cgi'
    # require 'base64'
    # require 'rubygems'
    # require 'hmac-sha1'

    attr_accessor :requestURL

    URL_TEMPLATE = %Q[http://:apiHost:/:apiRoot:/:api:/:url:?AccessID=:accessID:&Expires=:expiration:&Signature=:signature:]
    MAX_URL_LENGTH = 500

    def self.run(options)
      self.new(options).run
    end

    def self.run_raw(options)
      self.new(options).run_raw
    end

    def initialize(options)

      new_vals = {}
      if options[:url]
        case options[:url]
        when String
          if options[:url].length > MAX_URL_LENGTH
            raise ArgumentError.new("Request URLs must be < #{MAX_URL_LENGTH} long")
          end
          new_vals = {:url => CGI::escape(options[:url].sub(/^https?:\/\//, '')) }
        when Array
          @body = options[:url].collect{ |u| u.sub(/^https?:\/\//, '') }
          new_vals = {:url => ""}
        else
          raise "URL most be a String or an Array"
        end
      end

      @requestURL = URL_TEMPLATE.template(signRequest(options.merge(new_vals)))
      @requestURL += "&" + options[:query].collect{|k,v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}"}.join('&') if options[:query] && Hash === options[:query]
      @requestURL += "&" + options[:query] if options[:query] && String === options[:query]

      options[:offset] = 0 if options[:offset] && options[:offset] < 0
      @requestURL += "&Offset=#{options[:offset]}" if options[:offset]

      options[:limit] = 1000 if options[:limit] && options[:limit] > 1000
      @requestURL += "&Limit=#{options[:limit]}" if options[:limit]

      [:AnchorPhraseRid, :AnchorTermRid, :SourceDomain].each do |key|
        @requestURL += "&#{key}=#{options[key]}" if options[key]
      end
    end

    def run
      res = fetch(URI.parse(@requestURL))
      # res = fetch(URI.parse('http://martian.at/other/ose.json'))
      return Response.new(self, res)
    end

    def run_raw
      fetch(URI.parse(@requestURL)).body
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
      raise Linkscape::RecursionError, 'HTTP redirect too deep' if limit == 0

      # Fetch with a POST of thers is a body
      conn = Faraday.new(:url => uri) do |f|
        f.use FaradayMiddleware::FollowRedirects, :limit => limit
        f.adapter Faraday.default_adapter
      end
      response = if @body
        conn.post do |req|
          req.body = @body.to_json
        end
      else
        conn.get
      end

      if response.success?
        response
      elsif (500..599).include?(response.status)
        raise Linkscape::InternalServerError, error_msg(e)
      else
        raise Linkscape::HTTPStatusError, error_msg(e)
      end

    rescue Timeout::Error, Timeout::ExitException => e
      raise Linkscape::TimeoutError, error_msg(e)
    rescue ::EOFError => e
      raise Linkscape::EOFError, error_msg(e)
    rescue SystemCallError, Faraday::Error, Net::ProtocolError, SocketError => e
      raise Linkscape::Error, error_msg(e)
    end

  private

    def error_msg(error)
      "#{error.class}: #{error.message}"
    end
  end
end
