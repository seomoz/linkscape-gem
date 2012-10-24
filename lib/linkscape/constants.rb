directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'constants', 'anchor-metrics')
require File.join(directory, 'constants', 'url-metrics')
require File.join(directory, 'constants', 'link-metrics')

module Linkscape
  module Constants
    URLResponseFields = {

      :uu => {
        :name => 'URL',
        :key => :url,
        :desc => %Q[The URL in question, as it has been canonicalized in the Linkscape index],
      },
      :urid => {
        :name => 'Internal ID',
        :key => :internal_id,
        :desc => %Q[Internal ID of the URL],
      },
      :ur => {
        :name => 'Canonical URL',
        :key => :canonical_url,
        :desc => %Q[If the URL in question performs some kind of search engine canonicalization that is known to Linkscape (e.g., a 301 redirect), this field will contain the target of the canonicalization],
      },
      :urrid => {
        :name => 'Canonical URL Internal ID',
        :key => :canonical_internal_id,
        :desc => %Q[Internal ID of the canonical URL],
      },

      :us => {
        :name => 'HTTP Status',
        :key => :status,
        :desc => %Q[The HTTP status of the target URL],
      },
      :ut => {
        :name => 'Page Title',
        :key => :title,
        :desc => %Q[The title of the target URL, if a title is available],
      },

      :ff => {
        :name => 'Time of Last FQ Domain Update',
        :key => :fq_domain_updated_at,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the FQ domain of the target URL],
      },
      :pf => {
        :name => 'Time of Last PL Domain Update',
        :key => :pl_domain_updated_at,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the PL domain of the target URL],
      },
      :uf => {
        :name => 'Time of Last Update',
        :key => :updated_at,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the target URL],
      },

      :fid => {
        :name => 'Number of Links to FQ Domain',
        :key => :fq_domain_fq_domains_linking,
        :desc => %Q[The number of domains with at least one link to any page on the FQ domain of the target URL],
      },
      :fipl => {
        :name => 'Number of Links to FQ Domain',
        :key => :fq_domain_pl_domains_linking,
        :desc => %Q[The number of domains with at least one link to any page on the FQ domain of the target URL],
      },
      :feid => {
        :name => 'Number of External Juice-Passing Links to this Subdomain',
        :key => :fq_domain_external_links,
        :desc => %Q[the number of external (from other subdomains), juice-passing links to pages on this subdomain],
      },
      :pid => {
        :name => 'Number of Links to PL Domain',
        :key => :pl_domain_pl_domains_linking,
        :desc => %Q[The number of domains with at least one link to any page on the PL domain of the target URL],
      },
      :peid => {
        :name => 'Number of External Juice-Passing Links to this Domain',
        :key => :pl_domain_external_links,
        :desc => %Q[the number of external (from other root domains), juice-passing links to pages on this root domain],
      },
      :uid => {
        :name => 'Number of Links',
        :key => :links,
        :desc => %Q[The number of internal and external, juice and non-juice passing links to the target URL in the Linkscape index],
      },
      :fuid => {
        :name => 'Number of Links to Subdomain',
        :key => :fq_domain_links,
        :desc => %Q[The number of internal and external, juice and non-juice passing links to the subdomain of the target URL in the Linkscape index],
      },
      :puid => {
        :name => 'Number of Links to Root Domain',
        :key => :pl_domain_links,
        :desc => %Q[The number of internal and external, juice and non-juice passing links to the root domain of the target URL in the Linkscape index],
      },
      :ujid => {
        :name => 'Number of Juice-passing Links',
        :key => :juice_links,
        :desc => %Q[The number of juice passing links (internal or external) to the target URL in the Linkscape index],
      },
      :ueid => {
        :name => 'Number of External Juice-Passing Links',
        :key => :external_links,
        :desc => %Q[The number of external (from other subdomains), juice passing links to the target URL in the Linkscape index],
      },

      :fejp => {
        :name => 'External mozRank sum of all FQ Domain Pages',
        :key => :fq_domain_external_mozrank_sum,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :fjp => {
        :name => 'mozRank sum of all FQ Domain Pages',
        :key => :fq_domain_mozrank_sum,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :pejp => {
        :name => 'External mozRank sum of all PL Domain Pages',
        :key => :pl_domain_external_mozrank_sum,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index],
      },
      :pjp => {
        :name => 'mozRank sum of all PL Domain Pages',
        :key => :pl_domain_mozrank_sum,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index],
      },

      :fejr => {
        :name => 'External mozRank sum of all FQ Domain Pages (raw)',
        :key => :fq_domain_external_mozrank_sum_raw,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :fjr => {
        :name => 'mozRank sum of all FQ Domain Pages (raw)',
        :key => :fq_domain_mozrank_sum_raw,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :pejr => {
        :name => 'External mozRank sum of all PL Domain Pages (raw)',
        :key => :pl_domain_external_mozrank_sum_raw,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index],
      },
      :pjr => {
        :name => 'mozRank sum of all PL Domain Pages (raw)',
        :key => :pl_domain_mozrank_sum_raw,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index],
      },

      :fmrp => {
        :name => 'mozRank of FQ Domain',
        :key => :fq_domain_mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index],
      },
      :pmrp => {
        :name => 'mozRank of PL Domain',
        :key => :pl_domain_mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the PL domain of target URL in the Linkscape index],
      },
      :umrp => {
        :name => 'mozRank',
        :key => :mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the target URL in the Linkscape index],
      },

      :fmrr => {
        :name => 'mozRank of FQ Domain (raw)',
        :key => :fq_domain_mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index],
      },
      :pmrr => {
        :name => 'mozRank of PL Domain (raw)',
        :key => :pl_domain_mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the PL domain of the target URL in the Linkscape index],
      },
      :umrr => {
        :name => 'mozRank (raw)',
        :key => :mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the target URL in the Linkscape index],
      },

      :ftrp => {
        :name => 'mozTrust of FQ Domain',
        :key => :fq_domain_moztrust,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index],
      },
      :ptrp => {
        :name => 'mozTrust of PL Domain',
        :key => :pl_domain_moztrust,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index],
      },
      :utrp => {
        :name => 'mozTrust',
        :key => :moztrust,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the target URL in the Linkscape index],
      },
      :ftrr => {
        :name => 'mozTrust of FQ Domain (raw)',
        :key => :fq_domain_moztrust_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index],
      },
      :ptrr => {
        :name => 'mozTrust of PL Domain (raw)',
        :key => :pl_domain_moztrust_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index],
      },
      :utrr => {
        :name => 'mozTrust (raw)',
        :key => :moztrust_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the target URL in the Linkscape index],
      },

      :uemrp => {
        :name => 'External mozRank',
        :key => :external_mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the target URL due to external links in the Linkscape index],
      },
      :uemrr => {
        :name => 'External mozRank (raw)',
        :key => :external_mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the target URL due to external links in the Linkscape index],
      },
      :ufq => {
        :name => 'Fully-Qualified Domain',
        :key => :fq_domain,
        :desc => %Q[The fully qualified domain (FQ domain) as it's identified in the Linkscape index],
      },
      :uifq => {
        :name => 'Number of FQ Domains Linking',
        :key => :fq_domains_linking,
        :desc => %Q[The number of FQ domains with at least one link to the target URL in the Linkscape index],
      },
      :uipl => {
        :name => 'Number of PL Domains Linking',
        :key => :pl_domains_linking,
        :desc => %Q[The number of PL domains with at least one link to the target URL in the Linkscape index],
      },
      :upl => {
        :name => 'Pay-Level Domain',
        :key => :pl_domain,
        :desc => %Q[The pay-level domain (PL domain) as it's identified in the Linkscape index],
      },
      
      :ued => {
        :key => :all_external_links,
        :name => 'All external links page to page',
        :desc => %Q[The number of external links from one page to another (included followed and nofollowed).]
      },
      :ujfq => {
        :key => :juice_fq_domains_linking,
        :name => 'Followed Domains Linking Page',
        :desc => %Q[The number of unique domains with followed links to the target url.]
      },
      :ujp => {
        :key => :juice_ips_linking,
        :name => 'Followed IPs Linking',
        :desc => %Q[The number unique IPs with a followable link to a target url.]
      },
      :uip => {
        :key => :ips_linking,
        :name => 'IPs Linking',
        :desc => %Q[The total number of unique IPs linking to a target url.]
      },
      :ujpl => {
        :key => :juice_pl_domains_linking,
        :name => 'Followed Domains to Page',
        :desc => %Q[The number of unique domains with followed links to a given url.]
      },
      :uib => {
        :key => :cblocks_linking,
        :name => 'All Cblock Linking',
        :desc => %Q[The total number unique cblocks linking to a page.]
      },
      :ujb => {
        :key => :juice_cblocks_linking,
        :name => 'Followed CBLocks Linking',
        :desc => %Q[The total number unique cblocks with followed links to a page.]
      },
      :fjid => {
        :key => :fq_domain_juice_links,
        :name => 'Followed Subdomain Linking Domains',
        :desc => %Q[A count of all unique subdomains with followed links to the target domain.]
      },
      :fed => {
        :key => :fq_domain_all_external_links,
        :name => 'Subdomain External Links',
        :desc => %Q[The total number (followed and nofollowed) external links to the subdomain of the url.]
      },
      :fjf => {
        :key => :fq_domain_juice_fq_domains_linking,
        :name => 'Followed Subdomain Subdomains Links',
        :desc => %Q[The number of subdomains with followed links to the subdomain of the url.]
      },
      :fjd => {
        :key => :fq_domain_juice_pl_domains_linking,
        :name => 'Followed Domain Subdomains Links',
        :desc => %Q[The number of unique domains with followed links to the subdomain of the url.]
      },
      :pjid => {
        :key => :pl_domain_juice_links,
        :name => 'Followed Root Domain Links',
        :desc => %Q[The total number of followed links (both internal and external) from a page to a domain.]
      },
      :ped => {
        :key => :pl_domain_all_external_links,
        :name => 'All Root Domain External Links',
        :desc => %Q[The total number of external links (both followed and no-followed) from a page to a domain.]
      },
      :pjd => {
        :key => :pl_domain_juice_pl_domains_linking,
        :name => 'All Followed Root Domains Linking Domain',
        :desc => %Q[The total number of followed root domains linking to the target's domain.]
      },
      :pip => {
        :key => :pl_domain_ips_linking,
        :name => 'IPs Linking to Domain',
        :desc => %Q[The total number of unique IPs linking to the target's domain.]
      },
      :pjip => {
        :key => :pl_domain_juice_ips_linking,
        :name => 'Followed IPs Linking to Domain',
        :desc => %Q[The total number of unique IPs with followed links to the target's domain.]
      },
      :pib => {
        :key => :pl_domain_cblocks_linking,
        :name => 'All Cblock Linking Domain',
        :desc => %Q[The number of unique cblocks with a link to a domain.]
      },
      :pjb => {
        :key => :pl_domain_juice_cblocks_linking,
        :name => 'Followed Cblock Linking Domain',
        :desc => %Q[The total number of cblock with followed links to a domain.]
      },
      
      
      :upa => {
        :name => 'Page Authority',
        :key => :page_authority,
        :desc => %Q[The pretty (zero to one hundred, logarithmically scaled) page authority of the target URL],
      },
      :pda => {
        :name => 'Domain Authority',
        :key => :domain_authority,
        :desc => %Q[The pretty (zero to one hundred, logarithmically scaled) domain authority of the target URL's PL domain],
      },
      :upar => {
        :name => 'Page Authority (raw)',
        :key => :page_authority_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) page authority of the target URL],
      },
      :pdar => {
        :name => 'Domain Authority (raw)',
        :key => :domain_authority_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) domain authority of the target URL's PL domain],
      },
      
    }
    URLResponsePrefixes = {
      nil  => :source,
      :lu  => :target,
    }
    
    
    LinkResponseFields = {
      :t => {
        :name => 'Anchor Text',
        :key => :text,
        :desc => %Q[The anchor text of the link, including any markup (e.g. image tags with alt text)],
      },
      :src => {
        :name => 'Source Internal ID',
        :key => :source_internal_id,
        :desc => %Q[Internal ID of the source URL],
      },
      :rid => {
        :name => 'Link Internal ID',
        :key => :internal_id,
        :desc => %Q[Internal ID of the link],
      },
      :tgt => {
        :name => 'Target Internal ID',
        :key => :target_internal_id,
        :desc => %Q[Internal ID of the target URL],
      },
      :f => {
        :name => 'Link Flags',
        :key => :flags,
        :desc => %Q[A bit field indicating link attributes that apply to this link],
        :bitfield => :link,
      },
      :mrr => {
        :name => 'mozRank Passed (raw)',
        :key => :mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank passed to the target of this link],
      },
      :mrp => {
        :name => 'mozRank Passed',
        :key => :mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank passed to the target URL in the Linkscape index],
      },
    }
    LinkResponsePrefixes = {
      :l   => :link,
    }
    
    
    AnchorResponseFields = {
      :t => {
        :name => 'Anchor Text',
        :key => :text,
        :desc => %Q[The Anchor Text term or phrase],
      },
      :rid => {
        :name => 'Internal Target ID',
        :key => :record_id,
        :desc => %Q[Internal ID of the target URL],
      },
      :i => {
        :name => 'Internal Target Domain ID',
        :key => :pl_domain_id,
        :desc => %Q[Internal ID of the target PL Domain],
      },
      :iu => {
        :name => 'Internal Pages Linking',
        :key => :internal_pages_linking,
        :desc => %Q[Number of internal pages linking],
      },
      :if => {
        :name => 'Internal Subdomains Linking',
        :key => :internal_subdomains_linking,
        :desc => %Q[Number of internal subdomains linking],
      },
      :eu => {
        :name => 'External Pages Linking',
        :key => :external_pages_linking,
        :desc => %Q[number of external pages linking],
      },
      :ef => {
        :name => 'External Subdomains Linking',
        :key => :external_subdomains_linking,
        :desc => %Q[number of external subdomains linking],
      },
      :ep => {
        :name => 'External Domains Linking',
        :key => :external_domains_linking,
        :desc => %Q[number of external domains linking],
      },
      :imp => {
        :name => 'Internal mozRank',
        :key => :internal_mozrank,
        :desc => %Q[sum of internal mozrank],
      },
      :emp => {
        :name => 'External mozRank',
        :key => :external_mozrank,
        :desc => %Q[sum of external mozrank],
      },
      :f => {
        :name => 'flags',
        :key => :flags,
        :bitfield => :anchor,
        :desc => %Q[Flags],
      },
    }
    AnchorResponsePrefixes = {
      :app => :anchor,
      :apf => :anchor,
      :apu => :anchor,
      :atp => :anchor,
      :atf => :anchor,
      :atu => :anchor,
    }
    
    # For values calculated from other values.
    # format is  [ :unknown_fraction,  [ :whole_value, :known_fraction ] ]
    # result is  data[:unknown_fraction] = data[:whole_value] - data[:known_fraction]
    # IFF both data[:whole_value] and data[:known_fraction] are present.
    # 
    # Some calculated values are based on other calculated values,
    # so be careful about the ordering of the list.
    CalculationKeyMap = [
      [:unfollowed_external_links,                  [ :all_external_links,           :external_links                     ]],
      [:unfollowed_links,                           [ :links,                        :juice_links                        ]],
      [:juice_internal_links,                       [ :juice_links,                  :external_links                     ]],
      [:internal_links,                             [ :links,                        :all_external_links                 ]],
      [:unfollowed_internal_links,                  [ :internal_links,               :juice_internal_links               ]],
      
      [:fq_domain_unfollowed_external_links,        [ :fq_domain_all_external_links, :fq_domain_external_links           ]],
      [:fq_domain_unfollowed_links,                 [ :fq_domain_links,              :fq_domain_juice_links              ]],
      [:fq_domain_juice_internal_links,             [ :fq_domain_juice_links,        :fq_domain_external_links           ]],
      [:fq_domain_internal_links,                   [ :fq_domain_links,              :fq_domain_all_external_links       ]],
      [:fq_domain_unfollowed_internal_links,        [ :fq_domain_internal_links,     :fq_domain_juice_internal_links     ]],
      
      [:pl_domain_unfollowed_external_links,        [ :pl_domain_all_external_links, :pl_domain_external_links           ]],
      [:pl_domain_unfollowed_links,                 [ :pl_domain_links,              :pl_domain_juice_links              ]],
      [:pl_domain_juice_internal_links,             [ :pl_domain_juice_links,        :pl_domain_external_links           ]],
      [:pl_domain_internal_links,                   [ :pl_domain_links,              :pl_domain_all_external_links       ]],
      [:pl_domain_unfollowed_internal_links,        [ :pl_domain_internal_links,     :pl_domain_juice_internal_links     ]],
      
      [:unfollowed_fq_domains_linking,              [ :fq_domains_linking,           :juice_fq_domains_linking           ]],
      [:unfollowed_pl_domains_linking,              [ :pl_domains_linking,           :juice_pl_domains_linking           ]],
      [:fq_domain_unfollowed_fq_domains_linking,    [ :fq_domain_fq_domains_linking, :fq_domain_juice_fq_domains_linking ]],
      [:pl_domain_unfollowed_pl_domains_linking,    [ :pl_domain_pl_domains_linking, :pl_domain_juice_pl_domains_linking ]],
      [:fq_domain_unfollowed_pl_domains_linking,    [ :fq_domain_pl_domains_linking, :fq_domain_juice_pl_domains_linking ]],
      [:unfollowed_ips_linking,                     [ :ips_linking,                  :juice_ips_linking                  ]],
      [:unfollowed_cblocks_linking,                 [ :cblocks_linking,              :juice_cblocks_linking              ]],
      [:pl_domain_unfollowed_cblocks_linking,       [ :pl_domain_cblocks_linking,    :pl_domain_juice_cblocks_linking    ]],
      [:pl_domain_unfollowed_ips_linking,           [ :pl_domain_ips_linking,        :pl_domain_juice_ips_linking        ]],
    ]
    ResponseFields = {}
    
    URLResponsePrefixes.each do |prefix, subject|
      URLResponseFields.each do |k,v|
        v = v.dup.merge(
          :desc => "#{v[:desc]} (#{subject.to_s.capitalize})",
          :source => "#{prefix}#{k}".to_sym,
          :subject => subject
        )
        ResponseFields[v[:source]] = v
      end
    end
    LinkResponsePrefixes.each do |prefix, subject|
      LinkResponseFields.each do |k,v|
        v = v.dup.merge(
          :desc => "#{v[:desc]} (#{subject.to_s.capitalize})",
          :source => "#{prefix}#{k}".to_sym,
          :subject => subject
        )
        ResponseFields[v[:source]] = v
      end
    end
    AnchorResponsePrefixes.each do |prefix, subject|
      AnchorResponseFields.each do |k,v|
        v = v.dup.merge(
          :desc => "#{v[:desc]} (#{subject.to_s.capitalize})",
          :source => "#{prefix}#{k}".to_sym,
          :subject => subject
        )
        ResponseFields[v[:source]] = v
      end
    end
    
    ResponseFields.keys.each {|k| ResponseFields[ResponseFields[k][:key]] ||= ResponseFields[k] if ResponseFields[k][:key] }
    
    LongestNameLength = ResponseFields.collect{|k,v|v[:name].length}.max
    LongestKeyLength = ResponseFields.collect{|k,v|v[:key].to_s.length}.max
    
  end
end
