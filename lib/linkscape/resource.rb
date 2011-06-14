require "active_resource"
require "linkscape/cached_resource"
require "will_paginate"

##
# A generic linkscape resource class. Actual resources should extend this
# class. They will magically work if named appropriately.
class Linkscape::Resource < ActiveResource::Base
  include Linkscape::CachedResource
  
  # URI to API
  self.site = "http://lsapi.seomoz.com/linkscape"
  
  # API always serves JSON
  self.format = :json
  
  self.include_root_in_json = false
  
  ##
  # A poor implementation of caching. This isnt caching. This is used internally
  # when a true cache store has not been provided. When this happens, results are
  # cached only for the duration of the session.
  @@crummy_cache = {}
  
  ##
  # Override the load method that hydrates this instance with data off the wire or
  # from a 'new' instantiation. We add some additional logic to alias cryptic property
  # names to something more helpful.
  #
  # @param attributes [Hash] key/value pairs of the raw data
  def load(attributes = {})
    super
    attributes.each do |key, value|
      property_alias = Linkscape::Fields::MACHINE[key.to_sym]
      if property_alias
        @attributes[property_alias[:human].to_s] = value.dup rescue value
        @attributes.delete key.to_s
      end
    end
  end
  
  ##
  # Copied from ActiveResource::Base. Modified slightly to return an
  # attribute if exists before attemptingo to parse out equal signs and
  # question marks.
  # 
  # @author Brad Seefeld (brad@urbaninfluence.com)
  def method_missing(method_symbol, *arguments) #:nodoc:
    method_name = method_symbol.to_s

    return attributes[method_name] if attributes.include?(method_name)
    
    if method_name =~ /(=|\?)$/
      case $1
      when "="
        attributes[$`] = arguments.first
      when "?"
        attributes[$`]
      end
    else
      # not set right now but we know about it
      return nil if known_attributes.include?(method_name)
      super
    end
  end
  
  ##
  # Cache the max offset for the given search params.
  #
  # @param params [Hash] A hash of the query parameters that are being used in the search.
  # @param max_offset [Number] The max number of results that could be returned by this search.
  def self.set_cached_max_offset(params, max_offset)
    page_key = pagination_key(params)
    page_key << "max_offset"
    
    @@crummy_cache[page_key] = max_offset
    Linkscape.config.cache.write(page_key, max_offset)
  end
  
  ##
  # Fetch the max number of results ever found for the given search params.
  #
  # @param params [Hash] The search parameters.
  # @return [Number|Nil] The max number of results or nil if not known.
  def self.get_cached_max_offset(params)
    page_key = pagination_key(params)
    page_key << "max_offset"
    offset = Linkscape.config.cache.read(page_key)
    unless offset
      offset = @@crummy_cache[page_key]
    end
        
   offset
  end
  
  ##
  # Provide the path to a specific element. We override the default functionality
  # so that the 'id' (in this case a URL) becomes part of the path. We also omit
  # any file extension.
  #
  # @param id [String|Number] ID of the element.
  # @param prefix_options [Hash] Options that will become part of the path.
  # @param query_options [Hash] Options that will become part of the query string.
  # @return [String] The path to the element.
  def self.element_path(id, prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    "#{prefix(prefix_options)}#{collection_name}/#{CGI::escape id.to_s}#{query_string(query_options)}"        
  end
  
  ##
  # Override the behavior of the collection path. This path differs in that
  # the 'site' URL param becomes part of the URL. Instead of resource?site=value,
  # we have resource/value. This method also takes care to escape the value
  # of the site param. You should pass it in as a raw string.
  #
  # @return [String] The path to this resource.
  # @throws [ArgumentError] If the site param is not specified
  def self.collection_path(prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    
    site = query_options.delete(:site)
    raise ArgumentError, "A site parameter is expected" unless site
    site = CGI::escape(site)
    
    # Handle case sensitivity issue.
    if !query_options[:Sort] and query_options[:sort]
      query_options[:Sort] = query_options[:sort]
    end
    query_options.delete :sort 
    
    # Handle case sensitivity issue.
    if !query_options[:Scope] and query_options[:scope]
      query_options[:Scope] = query_options[:scope]
    end
    query_options.delete :scope
    
    # Convert source columns to a bit field.
    source_cols = columns_to_bits(query_options[:source_cols])
    query_options.delete(:source_cols)
    
    if source_cols > 0
      query_options[:SourceCols] = source_cols
    end
    
    target_cols = columns_to_bits(query_options[:target_cols])
    query_options.delete(:target_cols)
    if target_cols > 0
      query_options[:TargetCols] = target_cols
    end
    
    "#{prefix(prefix_options)}#{collection_name}/#{site}#{query_string(query_options)}"
  end
  
  ##
  # Find the number of possible results for the given site and parameters.
  #
  # @param site [String] The site we are searching for
  # @param params [Hash] Any additional parameters that is being sent to the API.
  # @return [Number|Nil] The total number of records this search could yield. Nil if not known.
  def self.count(site, params = {})
    raise ArgumentError, "Site cannot be nil" unless site
    params = {} unless params
    params[:site] = site
    max_offset = get_cached_max_offset(params)
    return max_offset
  end
  
  ##
  # Paginate the remote resource. This method is especially useful because it provides
  # smart pagination. If you request page 100 but only 56 pages are available, you will
  # automatically be directed to page 56. This is useful because most of the time, the client
  # is not aware of the real number of pages. This method will lazily discover the max number
  # of pages available.
  #
  # @param page [Number] The page number where 1 is the first page.
  # @param limit [Number] The desired number of items to appear on a page.
  # @param site [String] The string value of the site to send to the remote.
  # @param params [Hash] A hash of additional query parameters to send to remote.
  # @param gracefully_paginate [Boolean] If this method should automatically find the max page
  # @return [Array|WillPaginate::Collection] An array that has been enhanced with WillPaginate::Collection methods.
  def self.paginate(page, limit, site, params = {}, gracefully_paginate = true)
    page = page.to_i
    page = 1 if page <= 0
    params[:site] = site
    params[:Offset] = (page - 1) * limit
    params[:Limit] = limit
    
    Linkscape.config.logger.info "Querying remote with #{params.to_s}"
    results = find(:all, :params => params)

    # Attempt to find the last page.
    if gracefully_paginate && results.length == 0 && page > 1
      return gracefully_paginate(page, limit, site, params)
    end
    
    # Attempt to determine the max offset
    if results.length > 0 && results.length < limit
      max_offset = (page - 1) * limit + results.length
      set_cached_max_offset(params, max_offset)
    end
    
    WillPaginate::Collection.create(page, limit, count(site, params)) do |pager|
      pager.replace(results)
    end
  end
  
private
  
  ##
  # 'Gracefully' paginate through the resource. This pagination method will automatically
  # find the last page if a page greater than the max is specified. For example, if I ask
  # for page 100, but only 10 pages exist, this method will automatically figure out that
  # page 10 is the max page and will return that page's contents instead. This is especially
  # helpful since the API does not provide any information for paging and often times, client
  # applications are blindly paging through the results. 
  #
  # If a cache client has been provided, the results are cached.
  #
  # @param page [Number] The page number. Should be > 0
  # @param limit [Number] The max number of results to appear on a page
  # @param site [String] The site we are querying for.
  # @param params [Hash] Any extra query parameters.
  # @return [Array|WillPaginate::Collection] An array with the results enhanced with will_paginate methods.
  def self.gracefully_paginate(page, limit, site, params = {})
    Linkscape.config.logger.info "We didnt find any results and the users page is greater than 1."
    
    page_key = pagination_key(params)
    
    max_offset = get_cached_max_offset(params)
    max_offset = max_offset.to_i if max_offset
    
    if max_offset
      Linkscape.config.logger.info "The max offset is known (#{max_offset}) so we will jump directly to the last page."
      num_last_page = max_offset % limit # Find the length of the last page
      if num_last_page == 0
        num_last_page = limit
      end
      params[:Offset] = max_offset - num_last_page
      results = find(:all, :params => params)
      page = (max_offset / limit).ceil + 1
    end
    
    # Check again in case we were able to query knowing the max offset
    if !results || results.length == 0
      Linkscape.config.logger.info "The max offset is not known so we will binary search backwards for the greatest page."
    
      max_page_found = 1
      partial_found = false
      min = 1
      max = page
      
      empty_pages = [page]
      
      while (!partial_found && min > 0 && min <= max)
      
        mid = ((max - min).to_f / 2).ceil
        page = mid + min
              
        params[:Offset] = (page - 1) * limit
        Linkscape.config.logger.info "Querying remote with #{params.to_s}"
        results = find(:all, :params => params)
        
        if results.length > 0 && page > max_page_found
          max_page_found = page
        elsif results.length == 0
          empty_pages << page
        end
      
        partial_found = (results.length > 0 && results.length < limit)
        
        # If we found a full page, was the next page going to be empty?
        partial_found ||= (results && results.length > 0 && empty_pages.include?(page + 1))
        
        if results.length >= limit
          min = page
        else
          max = page - 1
        end
      end
      
      max_offset = (max_page_found - 1) * limit + results.length
      set_cached_max_offset(params, max_offset)
    end
    
    WillPaginate::Collection.create(page, limit, count(site, params)) do |pager|
      pager.replace(results)
    end
  end
  
  ##
  # Create a unique key from the given parameters.
  # 
  # @params[Hash] The parameters that are being sent to the remote API
  # @return [String] A unique string to be used like a hash key
  def self.pagination_key(params)
    unique_hash = ""
    Hash[params.sort].each do |key,value|
      unless [:Limit, :Offset].include?(key)
        unique_hash << "&" << key.to_s << "=" << value.to_s
      end
    end
    unique_hash
  end
  
  ##
  # Converts the given human readable columns to a bit field.
  #
  # @param columns [Hash] human_readable_key => value
  # @return A bit field
  def self.columns_to_bits(columns)
    return 0 unless columns
    bits = 0
    columns.each do |key|
      col = Linkscape::Fields::HUMAN[key.to_sym]
      if col
        bits |= col[:flag]
      else
        Linkscape.config.logger.error "#{key.to_s} is not a recognized column."
      end
    end
    bits
  end
  
  ##
  # The crummy cache lets us cache data between requests. Its not an actual
  # cache. To facilitate resetting this during unit tests, we provide this
  # method.
  def self.reset_crummy_cache
    @@crummy_cache = {}
  end
end