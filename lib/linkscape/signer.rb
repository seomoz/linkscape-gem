require 'cgi'
require 'digest/sha1'
require 'digest/hmac'

module Linkscape
  class Signer
    def self.sign_params(params, keys_to_sign = [:access_id, :expiration])
      params[:expiration] ||= Time.now.to_i + 60
      params[:access_id] ||= Linkscape.config.access_id
      string_to_sign = keys_to_sign.collect{|k| params[k].to_s}.join("\n")
      key ||= Linkscape.config.access_key
      signature = CGI::escape(Digest::HMAC.base64digest(key, string_to_sign, Digest::SHA1).chomp)
      params[:signature] = signature
    end
  end
end
