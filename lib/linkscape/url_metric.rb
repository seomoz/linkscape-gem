##
# Resource model for a URL Metric. One URL Metric exists per URL.
#
class Linkscape::UrlMetric < Linkscape::Resource

  # The LSAPI path for this resource.
  self.collection_name = "url-metrics"

  # A magical number that the API returns if the resource is not found (instead of a 404).
  NOT_FOUND_ID = 2**64 - 1

  ##
  # Generate the path part of the URL to find a single resource.
  # 
  # @param [String] id The unique ID of the resource. Site in our case.
  # @param [Hash] prefix_options
  # @param [Hash] query_options
  # @return [String] The path part of the URL.
  # @author Brad Seefeld (brad@urbaninfluence.com)
  def self.element_path(id, prefix_options = {}, query_options = nil)
    Linkscape.wrap_errors do
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?

      # Init defaults as needed
      query_options[:Cols] = query_options[:cols]
      query_options.delete(:cols)
      query_options[:Cols] = get_cols unless query_options[:Cols]
      query_options[:Cols] = columns_to_bits(query_options[:Cols])
      super
    end
  end

  ##
  # @return [Boolean] True if the metrics were found.
  # @author Brad Seefeld (brad@urbaninfluence.com)
  def found?
    return false unless @attributes[:internal_id]
    internal_id != NOT_FOUND_ID
  end

  ##
  # @return [Boolean] True if the supplied URL was canonical.
  # @author Brad Seefeld (brad@urbaninfluence.com)
  def canonical?
    return false unless @attributes[:internal_id] and @attributes[:canonical_internal_id]
    internal_id == canonical_internal_id
  end

  def num_internal_follow_links_to_page
    return nil unless present?(:num_follow_links_to_page, :num_external_follow_links_to_page)    
    num_follow_links_to_page - num_external_follow_links_to_page
  end

  def num_external_nofollow_links_to_page
    return nil unless present?(:num_external_links_to_page, :num_external_follow_links_to_page)
    num_external_links_to_page - num_external_follow_links_to_page
  end

  def num_internal_nofollow_links_to_page
    return nil unless present?(:num_nofollow_links_to_page, :num_external_nofollow_links_to_page)
    num_nofollow_links_to_page - num_external_nofollow_links_to_page
  end

  def num_internal_links_to_page
    return nil unless present?(:num_links, :num_external_links_to_page)    
    num_links - num_external_links_to_page
  end

  def num_internal_follow_links_to_subdomain
    return nil unless present?(:num_follow_links_to_subdomain, :num_external_follow_links_to_subdomain)
    num_follow_links_to_subdomain - num_external_follow_links_to_subdomain
  end

  def num_internal_links_to_subdomain
    return nil unless present?(:num_links_to_subdomain, :num_external_links_to_subdomain)
    num_links_to_subdomain - num_external_links_to_subdomain
  end

  def num_external_nofollow_links_to_subdomain
    return nil unless present?(:num_external_links_to_subdomain, :num_external_follow_links_to_subdomain)
    num_external_links_to_subdomain - num_external_follow_links_to_subdomain
  end

  def num_internal_nofollow_links_to_subdomain
    return nil unless present?(:num_nofollow_links_to_subdomain, :num_external_nofollow_links_to_subdomain)
    num_nofollow_links_to_subdomain - num_external_nofollow_links_to_subdomain
  end

  def num_internal_links_to_domain
    return nil unless present?(:num_links_to_domain, :num_external_links_to_domain)
    num_links_to_domain - num_external_links_to_domain
  end

  def num_external_nofollow_links_to_domain
    return nil unless present?(:num_external_links_to_domain, :num_external_follow_links_to_domain)
    num_external_links_to_domain - num_external_follow_links_to_domain
  end

  def num_internal_nofollow_links_to_domain
    return nil unless present?(:num_nofollow_links_to_domain, :num_external_nofollow_links_to_domain)
    num_nofollow_links_to_domain - num_external_nofollow_links_to_domain
  end

  def num_internal_follow_links_to_domain
    return nil unless present?(:num_follow_links_to_domain, :num_external_follow_links_to_domain)
    num_follow_links_to_domain - num_external_follow_links_to_domain
  end

  def to_json(options = {})
    Linkscape.wrap_errors do
      methods = [:canonical?, :num_internal_follow_links_to_page, :num_nofollow_links_to_page,
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
      :num_cblocks_to_domain, :num_nofollow_links_to_page, :num_nofollow_links_to_domain, :num_nofollow_links_to_subdomain
    ]
  end

private

  def present?(*fields)
    fields.each do |field|
      return nil unless self.respond_to?(field)
      return nil unless self.send(field)
    end
    true
  end
end
