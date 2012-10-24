module Linkscape
  module Constants
    module AnchorMetrics

      RequestBits = {
        :record_id => {
          :name => 'record_id',
          :flag => 2**0, # 1
          :desc => %Q[Internal record ID of the target]
        },
        :text => {
          :name => 'text',
          :flag => 2**1, # 2
          :desc => %Q[The anchor text term or phrase]
        },
        :pl_domain_id => {
          :name => 'pl_domain_id',
          :flag => 2**2, # 4
          :desc => %Q[Internal record ID of the target's domain]
        },
        :internal_pages_linking => {
          :name => 'Internal Pages Linking',
          :flag => 2**3, # 8
          :desc => %Q[the number of internal pages linking]
        },
        :internal_subdomains_linking => {
          :name => 'Internal Subdomains Linking',
          :flag => 2**4, # 16
          :desc => %Q[the number of internal subdomains linking]
        },
        :external_pages_linking => {
          :name => 'External Pages Linking',
          :flag => 2**5, # 32
          :desc => %Q[the number of external pages linking]
        },
        :external_subdomains_linking => {
          :name => 'External Subdomains Linking',
          :flag => 2**6, # 64
          :desc => %Q[the number of external subdomains linking]
        },
        :external_domains_linking => {
          :name => 'External Domains Linking',
          :flag => 2**7, # 128
          :desc => %Q[the number of external domains linking]
        },
        :internal_mozrank => {
          :name => 'Internal mozRank',
          :flag => 2**8, # 256
          :desc => %Q[the sum of mozRank passed along internal links]
        },
        :external_mozrank => {
          :name => 'External mozRank',
          :flag => 2**9, # 512
          :desc => %Q[the sum of mozRank passed along external links]
        },
        :flags => {
          :name => 'Flags',
          :flag => 2**10, # 1024
          :desc => %Q[a flags column]
        },
      }
      RequestBits[:all] = {
        :name => 'All columns',
        :flag => RequestBits.keys.inject(0) {|sum,k| sum | RequestBits[k][:flag]},
        :desc => %Q[Requests all known columns from the API]
      }

      ResponseFlags = {
        :alt_text => {
          :name => 'Alt Text',
          :flag => 2**0, # 1
          :desc => %Q[The anchor text is from the alt text of an image]
        },
      }
      ResponseFlagMap = {}
      ResponseFlags.each {|k,v| ResponseFlagMap[v[:flag]] = k }

    end
  end
end
