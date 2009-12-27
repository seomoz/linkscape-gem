module Linkscape
  module Constants
    module AnchorMetrics

      RequestBits = {
        :text => {
          :name => 'text',
          :flag => 2,
          :desc => %Q[The anchor text term or phrase]
        },
        :record_id => {
          :name => 'record_id',
          :flag => 4,
          :desc => %Q[Internal record ID of the target]
        },
        :internal_pages_linking => {
          :name => 'Internal Pages Linking',
          :flag => 8,
          :desc => %Q[the number of internal pages linking]
        },
        :internal_subdomains_linking => {
          :name => 'Internal Subdomains Linking',
          :flag => 16,
          :desc => %Q[the number of internal subdomains linking]
        },
        :external_pages_linking => {
          :name => 'External Pages Linking',
          :flag => 32,
          :desc => %Q[the number of external pages linking]
        },
        :external_subdomains_linking => {
          :name => 'External Subdomains Linking',
          :flag => 64,
          :desc => %Q[the number of external subdomains linking]
        },
        :external_domains_linking => {
          :name => 'External Domains Linking',
          :flag => 128,
          :desc => %Q[the number of external domains linking]
        },
        :internal_mozrank => {
          :name => 'Internal mozRank',
          :flag => 256,
          :desc => %Q[the sum of mozRank passed along internal links]
        },
        :external_mozrank => {
          :name => 'External mozRank',
          :flag => 512,
          :desc => %Q[the sum of mozRank passed along external links]
        },
        :flags => {
          :name => 'Flags',
          :flag => 1024,
          :desc => %Q[a flags column]
        },
      }
      RequestBits[:all] = {
        :name => 'All columnts',
        :flag => RequestBits.keys.inject(0) {|sum,k| sum + RequestBits[k][:flag]},
        :desc => %Q[Requests all known columns from the API]
      }

      ResponseFlags = {
        :alt_text => {
          :name => 'Alt Text',
          :flag => 1,
          :desc => %Q[The anchor text is from the alt text of an image]
        },
      }
      ResponseFlagMap = {}
      ResponseFlags.each {|k,v| ResponseFlagMap[v[:flag]] = k }

    end
  end
end
