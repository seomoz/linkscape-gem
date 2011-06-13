##
# Resource model for a URL Metric. One URL Metric exists per URL.
#
class Linkscape::UrlMetric < Linkscape::Resource
  
  self.collection_name = "url-metrics"
  
  NOT_FOUND_ID = 18446744073709551615
  
  def self.element_path(id, prefix_options = {}, query_options = nil)
    prefix_options, query_options = split_options(prefix_options) if query_options.nil?
    
    # Init defaults as needed
    query_options[:Cols] = query_options[:cols]
    query_options.delete(:cols)
    query_options[:Cols] = get_cols unless query_options[:Cols]
    query_options[:Cols] = columns_to_bits(query_options[:Cols])
    super
  end
  
  def is_found?
    return false unless @attributes[:internal_id]
    internal_id != NOT_FOUND_ID
  end
  
  def is_canonical?
    return false unless @attributes[:internal_id] and @attributes[:canonical_internal_id]
    internal_id == canonical_internal_id
  end
  
  def num_internal_follow_links_to_page
    return nil unless self.respond_to? :num_follow_links_to_page
    return nil unless self.respond_to? :num_external_follow_links_to_page
    return nil unless num_follow_links_to_page
    return nil unless num_external_follow_links_to_page
    
    num_follow_links_to_page - num_external_follow_links_to_page
  end
  
  def num_nofollow_links_to_page
    return nil unless self.respond_to? :num_links
    return nil unless self.respond_to? :num_follow_links_to_page
    return nil unless num_links
    return nil unless num_follow_links_to_page
    
    num_links - num_follow_links_to_page
  end
  
  def num_external_nofollow_links_to_page
    return nil unless self.respond_to? :num_external_links_to_page
    return nil unless self.respond_to? :num_external_follow_links_to_page
    return nil unless num_external_links_to_page
    return nil unless num_external_follow_links_to_page
    
    num_external_links_to_page - num_external_follow_links_to_page
  end
  
  def num_internal_nofollow_links_to_page
    return nil unless self.respond_to? :num_nofollow_links_to_page
    return nil unless self.respond_to? :num_external_nofollow_links_to_page
    return nil unless num_nofollow_links_to_page
    return nil unless num_external_nofollow_links_to_page
    
    num_nofollow_links_to_page - num_external_nofollow_links_to_page
  end
  
  def num_internal_links_to_page
    return nil unless self.respond_to? :num_links
    return nil unless self.respond_to? :num_external_links_to_page
    return nil unless num_links
    return nil unless num_external_links_to_page
    
    num_links - num_external_links_to_page
  end
  
  def num_internal_follow_links_to_subdomain
    return nil unless self.respond_to? :num_follow_links_to_subdomain
    return nil unless self.respond_to? :num_external_follow_links_to_subdomain
    return nil unless num_follow_links_to_subdomain
    return nil unless num_external_follow_links_to_subdomain
    
    num_follow_links_to_subdomain - num_external_follow_links_to_subdomain
  end
  
  def num_internal_links_to_subdomain
    return nil unless self.respond_to? :num_links_to_subdomain
    return nil unless self.respond_to? :num_external_links_to_subdomain
    return nil unless num_links_to_subdomain
    return nil unless num_external_links_to_subdomain
    
    num_links_to_subdomain - num_external_links_to_subdomain
  end
  
  def num_nofollow_links_to_subdomain
    return nil unless self.respond_to? :num_links_to_subdomain
    return nil unless self.respond_to? :num_follow_links_to_subdomain
    return nil unless num_links_to_subdomain
    return nil unless num_follow_links_to_subdomain
    
    num_links_to_subdomain - num_follow_links_to_subdomain
  end
  
  def num_external_nofollow_links_to_subdomain
    return nil unless self.respond_to? :num_external_links_to_subdomain
    return nil unless self.respond_to? :num_external_follow_links_to_subdomain
    return nil unless num_external_links_to_subdomain
    return nil unless num_external_follow_links_to_subdomain
    
    num_external_links_to_subdomain - num_external_follow_links_to_subdomain
  end
  
  def num_internal_nofollow_links_to_subdomain
    return nil unless self.respond_to? :num_nofollow_links_to_subdomain
    return nil unless self.respond_to? :num_external_nofollow_links_to_subdomain
    return nil unless num_nofollow_links_to_subdomain
    return nil unless num_external_nofollow_links_to_subdomain
    num_nofollow_links_to_subdomain - num_external_nofollow_links_to_subdomain
  end
  
  def num_internal_links_to_domain
    return nil unless self.respond_to? :num_links_to_domain
    return nil unless self.respond_to? :num_external_links_to_domain
    return nil unless num_links_to_domain
    return nil unless num_external_links_to_domain
    
    num_links_to_domain - num_external_links_to_domain
  end
  
  def num_nofollow_links_to_domain
    return nil unless self.respond_to? :num_links_to_domain
    return nil unless self.respond_to? :num_follow_links_to_domain
    return nil unless num_links_to_domain
    return nil unless num_follow_links_to_domain
    
    num_links_to_domain - num_follow_links_to_domain
  end
  
  def num_external_nofollow_links_to_domain
    return nil unless self.respond_to? :num_external_links_to_domain
    return nil unless self.respond_to? :num_external_follow_links_to_domain
    return nil unless num_external_links_to_domain
    return nil unless num_external_follow_links_to_domain
    
    num_external_links_to_domain - num_external_follow_links_to_domain
  end
  
  def num_internal_nofollow_links_to_domain
    return nil unless self.respond_to? :num_nofollow_links_to_domain
    return nil unless self.respond_to? :num_external_nofollow_links_to_domain
    return nil unless num_nofollow_links_to_domain
    return nil unless num_external_nofollow_links_to_domain
    
    num_nofollow_links_to_domain - num_external_nofollow_links_to_domain
  end
  
  def num_internal_follow_links_to_domain
    return nil unless self.respond_to? :num_follow_links_to_domain
    return nil unless self.respond_to? :num_external_follow_links_to_domain
    return nil unless num_follow_links_to_domain
    return nil unless num_external_follow_links_to_domain
    
    num_follow_links_to_domain - num_external_follow_links_to_domain
  end
  
  def to_json(options = {})
    methods = [:is_canonical?, :num_internal_follow_links_to_page, :num_nofollow_links_to_page,
      :num_external_nofollow_links_to_page, :num_internal_nofollow_links_to_page, :num_internal_links_to_page,
      :num_internal_follow_links_to_subdomain, :num_internal_links_to_subdomain, :num_nofollow_links_to_subdomain,
      :num_external_nofollow_links_to_subdomain, :num_internal_nofollow_links_to_subdomain,
      :num_internal_links_to_domain, :num_nofollow_links_to_domain, :num_external_nofollow_links_to_domain,
      :num_internal_nofollow_links_to_domain, :num_internal_follow_links_to_domain
    ]
    available = []
    methods.each do |method|
      if self.respond_to? method
        available << method
      end
    end
    options[:methods] = available unless options[:methods]
    super(options)
  end
  
  def self.get_cols
    [:title, :subdomain, :root_domain, :num_external_links_to_subdomain,
      :num_external_follow_links_to_domain, :page_authority, :domain_authority, 
      :num_external_links_to_page, :num_links_to_subdomain, :num_follow_links_to_subdomain, 
      :num_external_follow_links_to_subdomain, :num_root_domain_links_to_page, :num_links,
      :num_links_to_domain, :num_follow_links_to_domain, :num_external_links_to_domain,
      :num_external_follow_links_to_page, :num_follow_links_to_page, :subdomain, :mozrank,
      :moztrust, :subdomain_mozrank, :subdomain_moztrust, :root_domain_moztrust, :root_domain_mozrank,
      :num_domain_links_to_subdomain, :num_domain_links_to_domain, :canonical_url, :canonical_source_url,
      :num_follow_domains_to_page, :num_cblocks_to_page, :num_follow_domains_to_subdomain, :num_follow_domains_to_domain,
      :num_cblocks_to_domain
    ]
  end
end