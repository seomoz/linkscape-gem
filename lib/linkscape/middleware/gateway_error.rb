module Linkscape
  module Middleware
    class GatewayError < Faraday::Middleware
      INCAPSULA_ERROR_STATUS = 200
      INCAPSULA_ERROR_CONTENTTYPE_REGEX = %r{text/html}
      INCAPSULA_ERROR_BODY_SUBSTRING = 'Request unsuccessful. Incapsula incident ID'

      def call(env)
        @app.call(env).on_complete do
          if env[:status] == INCAPSULA_ERROR_STATUS &&
             env[:response_headers]['Content-Type'] =~ INCAPSULA_ERROR_CONTENTTYPE_REGEX &&
             env[:body].include?(INCAPSULA_ERROR_BODY_SUBSTRING)
            raise Linkscape::GatewayError.new(env[:body])
          end
        end
      end
    end
  end
end

