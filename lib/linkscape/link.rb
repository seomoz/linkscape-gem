require "linkscape/resource"
##
# Resourceful model implementation for Links.
#
class Linkscape::Link < Linkscape::Resource
  
  ##
  # Provide the path to the links resource collection. In particular, we provide
  # default values for required fields if none are given.
  #
  # @return [String] The path to the remote resource including all parameters
  def self.collection_path(prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    
    # Init defaults as needed
    query_options[:scope]       = :page_to_page unless (query_options[:scope] or query_options[:Scope])
    query_options[:sort]        = :domain_authority unless query_options[:sort]
    query_options[:target_cols] = get_target_cols unless query_options[:target_cols]
    query_options[:source_cols] = get_source_cols unless query_options[:source_cols]
    
    query_options[:Filter] = query_options[:filter] unless query_options[:Filter]
    query_options.delete(:filter)
    
    # Add link columns.
    link_cols = query_options[:link_cols]
    link_cols = get_link_cols unless link_cols
    query_options[:LinkCols] = columns_to_bits(link_cols) 
    query_options.delete(:link_cols)
    super
  end
  
  ##
  # Provide default target columns to fetch from remote.
  #
  # @return [Array] An array of target columns to use by default
  def self.get_target_cols
    [:canonical_target_url, :root_domain, :subdomain]
  end
  
  ##
  # Provide default source columns to fetch from remote.
  #
  # @return [Array] An array of source columns to use by default.
  def self.get_source_cols
    [:root_domain, :domain_authority, :page_authority, :title, :canonical_source_url, :num_domain_links_to_domain, :num_root_domain_links_to_page]
  end
  
  ##
  # Provide default link columns to fetch from remote.
  #
  # @return [Array] An array of LinkCols to use by default.
  def self.get_link_cols
    [:anchor_text, :flags]
  end
  
  ##
  # Hydrate this link instance with attributes fresh off the wire. In particular,
  # we convert the link bit flag to an expanded form where each flag is a key and
  # each value is true/false.
  #
  def load(attributes = {})
    super
    flags = @attributes[:lf]
    return unless flags
    
    flags = flags.to_i
    
    # Expand the bit flag field
    link_flags = [:is_nofollow, :is_same_sub_domain, :is_meta_refresh, :is_same_ip, 
      :is_same_cblock, :is_301, :is_302, :is_noscript, :is_off_screen, :is_meta_nofollow,
      :is_same_root_domain, :is_feed, :is_rel_canonical, :is_via_301]
      
    link_flags.each {|key|
      @attributes[key] = (flags & LinkscapeFields::HUMAN[key][:flag]) > 0
    }
    @attributes.delete(:lf) 
  end
  
  ##
  # Find the number of possible results for the given site and parameters. This
  # resource is able to cheat when calculating its counts by using the UrlMetrics
  # resource to find the correct count based on our current filters.
  #
  # @param site [String] The site we are searching on
  # @param params [Hash] Any additional parameters we are searching by.
  # @return [Number] The number of links for this site and params.
  def self.theoretical_count(site, params = {}, metrics = nil)
    
    # We need to look it up
    metrics = UrlMetric.find(site) unless metrics
    
    case params[:target]
    when "page"
      num = page_scope_count(metrics, params)
    when "subdomain"
      num = subdomain_scope_count(metrics, params)
    when "domain"
      num = domain_scope_count(metrics, params)
    end
    
    return num if num
    
    count(site, params)
  end
  
  private
  
  def self.domain_scope_count(metrics, params)
    case params[:source]
    when "internal"
      domain_scope_internal_count(metrics, params)
    when "external"
      domain_scope_external_count(metrics, params)
    when nil, ""
      domain_scope_both_count(metrics, params)
    end
  end
  
  def self.domain_scope_internal_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_internal_nofollow_links_to_domain
    when "followed_301"
      metrics.num_internal_follow_links_to_domain
    when nil, ""
      metrics.num_internal_links_to_domain
    end
  end
  
  def self.domain_scope_external_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_external_nofollow_links_to_domain
    when "followed_301"
      metrics.num_external_follow_links_to_domain
    when nil, ""
      metrics.num_external_links_to_domain
    end
  end
  
  def self.domain_scope_both_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_nofollow_links_to_domain
    when "followed_301"
      metrics.num_follow_links_to_domain
    when nil, ""
      metrics.num_links_to_domain
    end
  end
  
  def self.subdomain_scope_count(metrics, params)
    case params[:source]
    when "internal"
      subdomain_scope_internal_count(metrics, params)
    when "external"
      subdomain_scope_external_count(metrics, params)
    when nil, ""
      subdomain_scope_both_count(metrics, params)
    end
  end
  
  def self.subdomain_scope_both_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_nofollow_links_to_subdomain
    when "follow"
      metrics.num_follow_links_to_subdomain
    when nil, ""
      metrics.num_links_to_subdomain
    end
  end
  
  def self.subdomain_scope_internal_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_internal_nofollow_links_to_subdomain
    when "followed_301"
      metrics.num_internal_follow_links_to_subdomain
    when nil, ""
      metrics.num_internal_links_to_subdomain
    end
  end
  
  def self.subdomain_scope_both_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_nofollow_links_to_subdomain
    when "followed_301"
      metrics.num_follow_links_to_subdomain
    when nil, ""
      metrics.num_links_to_subdomain
    end
  end
  
  def self.subdomain_scope_external_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_external_nofollow_links_to_subdomain
    when "followed_301"
      metrics.num_external_follow_links_to_subdomain
    when nil, ""
      metrics.num_external_links_to_subdomain
    end
  end
  
  def self.page_scope_count(metrics, params)
    case params[:source]
    when "internal"
      page_scope_internal_count(metrics, params)
    when "external"
      page_scope_external_count(metrics, params)
    when nil, ""
      page_scope_both_count(metrics, params)
    end
  end
  
  def self.page_scope_both_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_nofollow_links_to_page
    when "followed_301"
      metrics.num_follow_links_to_page
    when nil, ""
      metrics.num_links
    end
  end
  
  def self.page_scope_external_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_external_nofollow_links_to_page
    when "followed_301"
      metrics.num_external_follow_links_to_page
    when nil, ""
      metrics.num_external_links_to_page
    end
  end
  
  def self.page_scope_internal_count(metrics, params)
    case params[:filter]
    when "nofollow"
      metrics.num_internal_nofollow_links_to_page
    when "followed_301"
      metrics.num_internal_follow_links_to_page
    when nil, ""
      metrics.num_internal_links_to_page
    end
  end
end