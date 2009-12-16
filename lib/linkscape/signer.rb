module Linkscape
  class Signer
    require 'rubygems'
    require 'cgi'
    require 'base64'
    require 'hmac-sha1'
    
    def self.signParams params, keysToSign=[:accessID, :expiration], key = nil
      params[:expiration] ||= Time.now.to_i + 60
      stringToSign = keysToSign.collect{|k| params[k].to_s}.join("\n")
      key ||= params[:secretKey]
      signature = CGI::escape( Base64.encode64( HMAC::SHA1.digest( key, stringToSign ) ).chomp )
      params[:signature] = signature
    end

  end
end
