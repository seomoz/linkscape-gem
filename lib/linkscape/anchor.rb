##
# Model a Linkscape Anchor resource.
# 
# @author Brad Seefeld (brad@urbaninfluence.com)
class Linkscape::Anchor < Linkscape::Resource
  
  # The API path
  self.collection_name = "anchor-text"

  def self.find(*arguments)
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
    params[:Cols]  = get_cols unless params[:Cols]
    params[:Cols]  = columns_to_bits(params[:Cols])
    params.delete(:cols)
    super(scope, options)
  end
  
  ##
  # Default list of columns for the anchors resource.
  #
  # @return [Array] An array of columns to fetch from the remote API.
  def self.get_cols
    [:anchors_anchor_text, :num_domain_links_with_anchor, :num_page_links_with_anchor, :root_domain, :anchor_flags, :internal_id]
  end
end