module Linkscape::UrlSchema
  def source_http?
    url_schema_flag_enabled?(0)
  end

  def source_https?
    url_schema_flag_enabled?(1)
  end

  def canonical_http?
    url_schema_flag_enabled?(24)
  end

  def canonical_https?
    url_schema_flag_enabled?(25)
  end

private

  def url_schema_flag_enabled?(bit)
    respond_to?(:url_schema) && (url_schema & 2 ** bit) == 1
  end
end
