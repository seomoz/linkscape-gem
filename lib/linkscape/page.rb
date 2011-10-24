##
# Model a Linkscape Page resource.
# 
# @author Brad Seefeld (brad@urbaninfluence.com)
class Linkscape::Page < Linkscape::Resource

  # The LSAPI path.
  self.collection_name = "top-pages"

  def self.find(*arguments)
    Linkscape.wrap_errors do
      scope   = arguments.slice!(0)
      options = arguments.slice!(0) || {}
      params = {}
      if options[:params]
        params = options[:params].clone
      end
      options[:params] = params

      # Add columns.
      cols = params[:cols]
      cols = get_cols unless cols
      params[:Cols] = columns_to_bits(cols) 
      params.delete(:cols)

      super(scope, options)
    end
  end

  ##
  # @return [Array<String|Symbol>] The columns to fetch for the Page.
  # @author Brad Seefeld (brad@urbaninfluence.com)
  def self.get_cols
    [:title, :num_root_domain_links_to_page, :url, :http_status_code, :num_links, :page_authority, :internal_id]
  end
end
