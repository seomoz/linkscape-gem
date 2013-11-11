##
# Model a Linkscape Anchor resource.
# 
# @author Brad Seefeld (brad@urbaninfluence.com)
class Linkscape::Anchor < Linkscape::Resource

  # The API path
  self.collection_name = "anchor-text"

  def self.find(*arguments)
    Linkscape.wrap_errors do
      scope   = arguments.slice!(0)
      options = arguments.slice!(0) || {}
      params = {}
      if options[:params]
        params = options[:params].clone
      end
      options[:params] = params

      # Init defaults as needed
      params[:scope] = :term_to_page unless (params[:scope] or params[:Scope])
      params[:sort]  = :domains_linking_page unless options[:sort]

      params[:Cols]  = params[:cols] unless params[:Cols]
      params[:Cols]  = COLS unless params[:Cols]
      params[:Cols]  = columns_to_bits(params[:Cols])
      params.delete(:cols)
      super(scope, options)
    end
  end

  COLS = [
    :anchor_flags,
    :anchors_anchor_text,
    :internal_id,
    :num_external_page_links_with_anchor,
    :num_external_root_domain_links_with_anchor,
    :num_internal_page_links_with_anchor,
    :root_domain,
    :url_schema
  ]

  def num_page_links_with_anchor
    if present?(:num_internal_page_links_with_anchor, :num_external_page_links_with_anchor)
      num_internal_page_links_with_anchor + num_external_page_links_with_anchor 
    end
  end
end
