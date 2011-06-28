require "linkscape/resource"
##
# Resourceful model implementation for Links.
#
class Linkscape::Link < Linkscape::Resource
  
  def self.find(*arguments)
    scope   = arguments.slice!(0)
    options = arguments.slice!(0) || {}
    params = {}
    if options[:params]
      params = options[:params].clone
    end
    options[:params] = params
    
    # Init defaults as needed
    params[:scope]       = :page_to_page unless (params[:scope] or params[:Scope])
    params[:sort]        = :domain_authority unless params[:sort]
    params[:target_cols] = get_target_cols unless params[:target_cols]
    params[:source_cols] = get_source_cols unless params[:source_cols]
    
    params[:Filter] = params[:filter] unless params[:Filter]
    params.delete(:filter)
    
    # Add link columns.
    link_cols = params[:link_cols]
    link_cols = get_link_cols unless link_cols
    params[:LinkCols] = columns_to_bits(link_cols) 
    params.delete(:link_cols)
    
    super(scope, options)
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
    link_flags = [:nofollow?, :same_sub_domain?, :meta_refresh?, :same_ip?, 
      :same_cblock?, :http_301?, :http_302?, :noscript?, :off_screen?, :meta_nofollow?,
      :same_root_domain?, :feed?, :rel_canonical?, :via_301?]
      
    link_flags.each {|key|
      @attributes[key] = (flags & Linkscape::Fields::HUMAN[key][:flag]) > 0
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
    metrics = Linkscape::UrlMetric.find(site) unless metrics
    
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