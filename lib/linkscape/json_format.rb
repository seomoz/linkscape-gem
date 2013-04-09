require 'active_resource/formats/json_format'

module Linkscape::JsonFormat
  extend ActiveResource::Formats::JsonFormat
  extend self

  # Prevents the removal of the root from a single-element hash.
  def decode(json)
    ActiveSupport::JSON.decode(json)
  end
end
