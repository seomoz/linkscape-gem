class Linkscape::Page < Linkscape::Resource
  
  self.collection_name = "top-pages"
  
  ##
  # Provide the path to the links resource collection. In particular, we provide
  # default values for required fields if none are given.
  #
  # @return [String] The path to the remote resource including all parameters
  def self.collection_path(prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    
    # Add columns.
    cols = query_options[:cols]
    cols = get_cols unless cols
    query_options[:Cols] = columns_to_bits(cols) 
    query_options.delete(:cols)
    super
  end
  
  def self.get_cols
    [:title, :num_root_domain_links_to_page, :url, :http_status_code, :num_links, :page_authority]
  end
end