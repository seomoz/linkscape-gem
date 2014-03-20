module Linkscape
  module Constants
    module URLMetrics

      RequestBits = {
        :title => {
          :name => 'Title',
          :flag => 2**0, # 1
          :desc => %Q[The title of the page if available. For example: "Request-Response Format"]
        },
        :url => {
          :name => 'URL',
          :flag => 2**2, # 4
          :desc => %Q[The url of the page.  For example: "apiwiki.seomoz.org/Request-Response+Format"]
        },
        :fq_domain => {
          :name => 'Subdomain',
          :flag => 2**3, # 8
          :desc => %Q[The subdomain of the url.  For example: "apiwiki.seomoz.org"]
        },
        :pl_domain => {
          :name => 'Root Domain',
          :flag => 2**4, # 16
          :desc => %Q[The root domain of the url.  For example: "seomoz.org"]
        },
        :external_links => {
          :name => 'External Links',
          :flag => 2**5, # 32
          :desc => %Q[The number of juice-passing external links to the url.]
        },
        :fq_domain_external_links => {
          :name => 'Subdomain External Links',
          :flag => 2**6, # 64
          :desc => %Q[The number of juice-passing external links to the subdomain of the url.]
        },
        :pl_domain_external_links => {
          :name => 'Root Domain External Links',
          :flag => 2**7, # 128
          :desc => %Q[The number of juice-passing external links to the root domain of the url.]
        },
        :juice_links => {
          :name => 'Juice-Passing Links',
          :flag => 2**8, # 256
          :desc => %Q[The number of juice-passing links (internal or external) to the url.]
        },
        :fq_domains_linking => {
          :name => 'Subdomains Linking',
          :flag => 2**9, # 512
          :desc => %Q[The number of subdomains with any pages linking to the url.]
        },
        :pl_domains_linking => {
          :name => 'Root Domains Linking',
          :flag => 2**10, # 1024
          :desc => %Q[The number of root domains with any pages linking to the url.]
        },
        :links => {
          :name => 'Links',
          :flag => 2**11, # 2048
          :desc => %Q[The number of links (juice-passing or not, internal or external) to the url.]
        },
        :fq_domain_links => {
          :name => 'Subdomain Links',
          :flag => 2**32, # 4294967296
          :desc => %Q[The number of links to any page on the subdomain of the url.]
        },
        :fq_domain_fq_domains_linking => {
          :name => 'Subdomain Subdomains Linking',
          :flag => 2**12, # 4096
          :desc => %Q[The number of subdomains with any pages linking to the subdomain of the url.]
        },
        :fq_domain_pl_domains_linking => {
          :name => 'Subdomain Root Domains Linking',
          :flag => 2**34, # 17179869184
          :desc => %Q[The number of domains with any pages linking to the subdomain of the url.]
        },
        :pl_domain_links => {
          :name => 'Root Domain Links',
          :flag => 2**33, # 8589934592
          :desc => %Q[The number of links to any page on the root domain of the url.]
        },
        :pl_domain_pl_domains_linking => {
          :name => 'Root Domain Root Domains Linking',
          :flag => 2**13, # 8192
          :desc => %Q[The number of root domains with any pages linking to the root domain of the url.]
        },
        :mozrank => {
          :name => 'mozRank',
          :flag => 2**14, # 16384
          :desc => %Q[The mozRank of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :fq_domain_mozrank => {
          :name => 'Subdomain mozRank',
          :flag => 2**15, # 32768
          :desc => %Q[The mozRank of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_mozrank => {
          :name => 'Root Domain mozRank',
          :flag => 2**16, # 65536
          :desc => %Q[The mozRank of the Root Domain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :moztrust => {
          :name => 'mozTrust',
          :flag => 2**17, # 131072
          :desc => %Q[The mozTrust of the url.    Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :fq_domain_moztrust => {
          :name => 'Subdomain mozTrust',
          :flag => 2**18, # 262144
          :desc => %Q[The mozTrust of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_moztrust => {
          :name => 'Root Domain mozTrust',
          :flag => 2**19, # 524288
          :desc => %Q[The mozTrust of the root domain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :external_mozrank => {
          :name => 'External mozRank',
          :flag => 2**20, # 1048576
          :desc => %Q[The portion of the url's mozRank coming from external links.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :fq_domain_external_mozrank_sum_raw => {
          :name => 'Subdomain External Domain Juice',
          :flag => 2**21, # 2097152
          :desc => %Q[The portion of the mozRank of all pages on the subdomain coming from external links.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_external_mozrank_sum_raw => {
          :name => 'Root Domain External Domain Juice',
          :flag => 2**22, # 4194304
          :desc => %Q[The portion of the mozRank of all pages on the root domain coming from external links.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :fq_domain_mozrank_sum_raw => {
          :name => 'Subdomain Domain Juice',
          :flag => 2**23, # 8388608
          :desc => %Q[The mozRank of all pages on the subdomain combined.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_mozrank_sum_raw => {
          :name => 'Root Domain Domain Juice',
          :flag => 2**24, # 16777216
          :desc => %Q[The mozRank of all pages on the root domain combined.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :canonical_url => {
          :name => 'Canonical URL',
          :flag => 2**28, # 268435456
          :desc => %Q[If the url canaonicalizes to a different form, that canonical form will be available in this field]
        },
        :status => {
          :name => 'HTTP Status Code',
          :flag => 2**29, # 536870912
          :desc => %Q[The HTTP status code recorded by Linkscape for this URL (if available)]
        },
        :page_authority => {
          :name => 'Page Authority',
          :flag => 2**35, # 34359738368
          :desc => %Q[The page authority of this URL. This will return the pretty 100-point score.]
        },
        :domain_authority => {
          :name => 'Domain Authority',
          :flag => 2**36, # 68719476736
          :desc => %Q[The page authority of all pages on the root domain. This will return the pretty 100-point score.]
        },
        :page_authority_raw => {
          :name => 'Raw Page Authority',
          :flag => 2**37, # 137438953472
          :desc => %Q[The page authority of this URL. This will return the raw score.]
        },
        :domain_authority_raw => {
          :name => 'Raw Domain Authority',
          :flag => 2**38, # 274877906944
          :desc => %Q[The page authority of all pages on the root domain. This will return the raw score.]
        },
        :all_external_links => {
          :name => 'All external links page to page',
          :flag => 2**39,
          :desc => %Q[The number of external links from one page to another (included followed and nofollowed).]
        },
        :juice_fq_domains_linking => {
          :name => 'Followed Domains Linking Page',
          :flag => 2**40,
          :desc => %Q[The number of unique domains with followed links to the target url.]
        },
        :juice_ips_linking => {
          :name => 'Followed IPs Linking',
          :flag => 2**41,
          :desc => %Q[The number unique IPs with a followable link to a target url.]
        },
        :ips_linking => {
          :name => 'IPs Linking',
          :flag => 2**42,
          :desc => %Q[The total number of unique IPs linking to a target url.]
        },
        :juice_pl_domains_linking => {
          :name => 'Followed Domains to Page',
          :flag => 2**43,
          :desc => %Q[The number of unique domains with followed links to a given url.]
        },
        :cblocks_linking => {
          :name => 'All Cblock Linking',
          :flag => 2**44,
          :desc => %Q[The total number unique cblocks linking to a page.]
        },
        :juice_cblocks_linking => {
          :name => 'Followed CBLocks Linking',
          :flag => 2**45,
          :desc => %Q[The total number unique cblocks with followed links to a page.]
        },
        :fq_domain_juice_links => {
          :name => 'Followed Subdomain Linking Domains',
          :flag => 2**46,
          :desc => %Q[A count of all unique subdomains with followed links to the target domain.]
        },
        :fq_domain_all_external_links => {
          :name => 'Subdomain External Links',
          :flag => 2**47,
          :desc => %Q[The total number (followed and nofollowed) external links to the subdomain of the url.]
        },
        :fq_domain_juice_fq_domains_linking => {
          :name => 'Followed Subdomain Subdomains Links',
          :flag => 2**48,
          :desc => %Q[The number of subdomains with followed links to the subdomain of the url.]
        },
        :fq_domain_juice_pl_domains_linking => {
          :name => 'Followed Domain Subdomains Links',
          :flag => 2**49,
          :desc => %Q[The number of unique domains with followed links to the subdomain of the url.]
        },
        :pl_domain_juice_links => {
          :name => 'Followed Root Domain Links',
          :flag => 2**50,
          :desc => %Q[The total number of followed links (both internal and external) from a page to a domain.]
        },
        :pl_domain_all_external_links => {
          :name => 'All Root Domain External Links',
          :flag => 2**51,
          :desc => %Q[The total number of external links (both followed and no-followed) from a page to a domain.]
        },
        :pl_domain_juice_pl_domains_linking => {
          :name => 'All Followed Root Domains Linking Domain',
          :flag => 2**52,
          :desc => %Q[The total number of followed root domains linking to the target's domain.]
        },
        :pl_domain_ips_linking => {
          :name => 'IPs Linking to Domain',
          :flag => 2**53,
          :desc => %Q[The total number of unique IPs linking to the target's domain.]
        },
        :pl_domain_juice_ips_linking => {
          :name => 'Followed IPs Linking to Domain',
          :flag => 2**54,
          :desc => %Q[The total number of unique IPs with followed links to the target's domain.]
        },
        :pl_domain_cblocks_linking => {
          :name => 'All Cblock Linking Domain',
          :flag => 2**55,
          :desc => %Q[The number of unique cblocks with a link to a domain.]
        },
        :pl_domain_juice_cblocks_linking => {
          :name => 'Followed Cblock Linking Domain',
          :flag => 2**56,
          :desc => %Q[The total number of cblock with followed links to a domain.]
        },
        :url_schema => {
          :name => 'URL schema (HTTP/HTTPS)',
          :flag => 2**61,
          :desc => 'If Mozscape has crawled HTTP and/or HTTPS'
        },

        # The following are calculated values. If you ask for them,
        # we'll convert it into a request for the fields they
        # depend on. In the Response, we'll then set the key from
        # those values.
        :unfollowed_external_links => {
          :flag => 2**39 | 2**5,
        },
        :unfollowed_links => {
          :flag => 2**11 | 2**8,
        },
        :juice_internal_links => {
          :flag => 2**8 | 2**5,
        },
        :internal_links => {
          :flag => 2**11 | 2**39,
        },
        :unfollowed_internal_links => {
          :flag => 2**11 | 2**39 | 2**8 | 2**5,
        },
        :fq_domain_unfollowed_external_links => {
          :flag => 2**47 | 2**6,
        },
        :fq_domain_unfollowed_links => {
          :flag => 2**32 | 2**46,
        },
        :fq_domain_juice_internal_links => {
          :flag => 2**46 | 2**6,
        },
        :fq_domain_internal_links => {
          :flag => 2**32 | 2**47,
        },
        :fq_domain_unfollowed_internal_links => {
          :flag => 2**32 | 2**47 | 2**46 | 2**6,
        },
        :pl_domain_unfollowed_external_links => {
          :flag => 2**51 | 2**7,
        },
        :pl_domain_unfollowed_links => {
          :flag => 2**33 | 2**50,
        },
        :pl_domain_juice_internal_links => {
          :flag => 2**50 | 2**7,
        },
        :pl_domain_internal_links => {
          :flag => 2**33 | 2**51,
        },
        :pl_domain_unfollowed_internal_links => {
          :flag => 2**33 | 2**51 | 2**50 | 2**7,
        },
        :unfollowed_fq_domains_linking => {
          :flag => 2**9 | 2**40,
        },
        :unfollowed_pl_domains_linking => {
          :flag => 2**10 | 2**43,
        },
        :fq_domain_unfollowed_fq_domains_linking => {
          :flag => 2**12 | 2**48,
        },
        :pl_domain_unfollowed_pl_domains_linking => {
          :flag => 2**13 | 2**52,
        },
        :fq_domain_unfollowed_pl_domains_linking => {
          :flag => 2**34 | 2**49,
        },
        :unfollowed_ips_linking => {
          :flag => 2**42 | 2**41,
        },
        :unfollowed_cblocks_linking => {
          :flag => 2**44 | 2**45,
        },
        :pl_domain_unfollowed_cblocks_linking => {
          :flag => 2**55 | 2**56,
        },
        :pl_domain_unfollowed_ips_linking => {
          :flag => 2**53 | 2**54,
        },
      }

      RequestBits[:all] = {
        :name => 'All columns',
        :flag => RequestBits.keys.inject(0) {|sum,k| sum | RequestBits[k][:flag]},
        :desc => %Q[Requests all known columns from the API]
      }

      UrlSchemaFlags = {
        :http_present => {
          :name => 'HTTP present',
          :flag => 2**0,
          :desc => %Q[An HTTP version of the URL was found.]
        },
        :https_present => {
          :name => 'HTTPS present',
          :flag => 2**1,
          :desc => %Q[An HTTPS version of the URL was found.]
        },
        :http_canonical => {
          :name => 'HTTP canonical',
          :flag => 2**24,
          :desc => %Q[An HTTP version of the URL is canonical.]
        },
        :https_canonical => {
          :name => 'HTTPS canonical',
          :flag => 2**25,
          :desc => %Q[An HTTPS version of the URL is canonical.]
        },
      }
    end
  end
end
