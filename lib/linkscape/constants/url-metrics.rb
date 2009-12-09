module Linkscape
  module Constants
    module URLMetrics

      RequestBits = {
        :title => {
          :name => 'Title',
          :flag => 1,
          :desc => %Q[The title of the page if available. For example: "Request-Response Format"]
        },
        :url => {
          :name => 'URL',
          :flag => 4,
          :desc => %Q[The url of the page.  For example: "apiwiki.seomoz.org/Request-Response+Format"]
        },
        :fq_domain => {
          :name => 'Subdomain',
          :flag => 8,
          :desc => %Q[The subdomain of the url.  For example: "apiwiki.seomoz.org"]
        },
        :pl_domain => {
          :name => 'Root Domain',
          :flag => 16,
          :desc => %Q[The root domain of the url.  For example: "seomoz.org"]
        },
        :external_links => {
          :name => 'External Links',
          :flag => 32,
          :desc => %Q[The number of juice-passing external links to the url.]
        },
        :fq_domain_external_links => {
          :name => 'Subdomain External Links',
          :flag => 64,
          :desc => %Q[The number of juice-passing external links to the subdomain of the url.]
        },
        :pl_domain_external_links => {
          :name => 'Root Domain External Links',
          :flag => 128,
          :desc => %Q[The number of juice-passing external links to the root domain of the url.]
        },
        :juice_links => {
          :name => 'Juice-Passing Links',
          :flag => 256,
          :desc => %Q[The number of juice-passing links (internal or external) to the url.]
        },
        :fq_domains_linking => {
          :name => 'Subdomains Linking',
          :flag => 512,
          :desc => %Q[The number of subdomains with any pages linking to the url.]
        },
        :pl_domains_linking => {
          :name => 'Root Domains Linking',
          :flag => 1024,
          :desc => %Q[The number of root domains with any pages linking to the url.]
        },
        :links => {
          :name => 'Links',
          :flag => 2048,
          :desc => %Q[The number of links (juice-passing or not, internal or external) to the url.]
        },
        :fq_domain_links => {
          :name => 'Subdomain Subdomains Linking',
          :flag => 4096,
          :desc => %Q[The number of subdomains with any pages linking to the subdomain of the url.]
        },
        :pl_domain_links => {
          :name => 'Root Domain Root Domains Linking',
          :flag => 8192,
          :desc => %Q[The number of root domains with any pages linking to the root domain of the url.]
        },
        :mozrank => {
          :name => 'mozRank',
          :flag => 16384,
          :desc => %Q[The mozRank of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :fq_domain_mozrank => {
          :name => 'Subdomain mozRank',
          :flag => 32768,
          :desc => %Q[The mozRank of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_mozrank => {
          :name => 'Root Domain mozRank',
          :flag => 65536,
          :desc => %Q[The mozRank of the Root Domain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :moztrust => {
          :name => 'mozTrust',
          :flag => 131072,
          :desc => %Q[The mozTrust of the url.    Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :fq_domain_moztrust => {
          :name => 'Subdomain mozTrust',
          :flag => 262144,
          :desc => %Q[The mozTrust of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_moztrust => {
          :name => 'Root Domain mozTrust',
          :flag => 524288,
          :desc => %Q[The mozTrust of the root domain of the url.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :external_mozrank => {
          :name => 'External mozRank',
          :flag => 1048576,
          :desc => %Q[The portion of the url's mozRank coming from external links.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :fq_domain_external_mozrank_sum_raw => {
          :name => 'Subdomain External Domain Juice',
          :flag => 2097152,
          :desc => %Q[The portion of the mozRank of all pages on the subdomain coming from external links.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_external_mozrank_sum_raw => {
          :name => 'Root Domain External Domain Juice',
          :flag => 4194304,
          :desc => %Q[The portion of the mozRank of all pages on the root domain coming from external links.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
          #     source.External mozRank sum of all PL Domain Pages (raw)                       - 9.8334596959365e-11
        },
        :fq_domain_mozrank_sum_raw => {
          :name => 'Subdomain Domain Juice',
          :flag => 8388608,
          :desc => %Q[The mozRank of all pages on the subdomain combined.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :pl_domain_mozrank_sum_raw => {
          :name => 'Root Domain Domain Juice',
          :flag => 16777216,
          :desc => %Q[The mozRank of all pages on the root domain combined.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        },
        :canonical_url => {
          :name => 'Canonical URL',
          :flag => 268435456,
          :desc => %Q[If the url canaonicalizes to a different form, that canonical form will be available in this field]
        },
        :status => {
          :name => 'HTTP Status Code',
          :flag => 536870912,
          :desc => %Q[The HTTP status code recorded by Linkscape for this URL (if available)]
        },

        :page_strength => {
          :name => 'Page Strength',
          :flag => 34359738368,
          :desc => %Q[The page strength of this URL. This will return the pretty 100-point score.]
        },
        :domain_authority => {
          :name => 'Domain Authority',
          :flag => 68719476736,
          :desc => %Q[The page strength of all pages on the root domain. This will return the pretty 100-point score.]
        },
        :page_strength_raw => {
          :name => 'Raw Page Strength',
          :flag => 137438953472,
          :desc => %Q[The page strength of this URL. This will return the raw score.]
        },
        :domain_authority_raw => {
          :name => 'Raw Domain Authority',
          :flag => 274877906944,
          :desc => %Q[The page strength of all pages on the root domain. This will return the raw score.]
        },

      }
      RequestBits[:all] = {
        :name => 'All columnts',
        :flag => RequestBits.keys.inject(0) {|sum,k| sum + RequestBits[k][:flag]},
        :desc => %Q[Requests all known columns from the API]
      }

    end
  end
end
