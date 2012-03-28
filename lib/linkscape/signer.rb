module Linkscape
  class Signer
    
    def self.signParams params, keysToSign=[:accessID, :expiration], key = nil
      params[:expiration] ||= Time.now.to_i + 300
      stringToSign = keysToSign.collect{|k| params[k].to_s}.join("\n")
      key ||= params[:secretKey]
      signature = CGI::escape( Base64.encode64( HMAC::SHA1.digest( key, stringToSign ) ).chomp )
      params[:signature] = signature
    end

  end
end
