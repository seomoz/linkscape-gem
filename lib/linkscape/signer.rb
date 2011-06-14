require 'cgi'
require 'base64'
require 'hmac-sha1'

module Linkscape
  class Signer
    
    def self.sign_params(params, keys_to_sign = [:access_id, :expiration], key = nil)
      params[:expiration] ||= Time.now.to_i + 60
      string_to_sign = keys_to_sign.collect{|k| params[k].to_s}.join("\n")
      key ||= Linkscape.config.access_key
      signature = CGI::escape(Base64.encode64(HMAC::SHA1.digest(key, string_to_sign)).chomp)
      params[:signature] = signature
    end
  end
end
