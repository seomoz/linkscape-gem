##
# Model a Linkscape Anchor resource.
# 
# @author Brad Seefeld (brad@urbaninfluence.com)
class Linkscape::Anchor < Linkscape::Resource
  
  # The API path
  self.collection_name = "anchor-text"

  ##
  # Provide the path to the anchors resource collection. In particular, we provide
  # default values for required fields if none are given.
  #
  # @return [String] The path to the remote resource including all parameters
  def self.collection_path(prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    
    # Init defaults as needed
    query_options[:scope]       = :term_to_page unless (query_options[:scope] or query_options[:Scope])
    query_options[:sort]        = :domains_linking_page unless query_options[:sort]
    
    query_options[:Cols]        = query_options[:cols] unless query_options[:Cols]
    query_options[:Cols]        = get_cols unless query_options[:Cols]
    query_options[:Cols]        = columns_to_bits(query_options[:Cols])
    query_options.delete(:cols)
    super
  end
  
  ##
  # Default list of columns for the anchors resource.
  #
  # @return [Array] An array of columns to fetch from the remote API.
  def self.get_cols
    [:anchors_anchor_text, :num_domain_links_with_anchor, :num_page_links_with_anchor, :root_domain, :anchor_flags]
  end
end