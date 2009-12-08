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
        :key => :fq_domain_links,
        :desc => %Q[The number of domains with at least one link to any page on the FQ domain of the target URL],
      },
      :feid => {
        :name => 'Number of External Juice-Passing Links to this Subdomain',
        :key => :fq_domain_external_links,
        :desc => %Q[the number of external (from other subdomains), juice-passing links to pages on this subdomain],
      },
      :pid => {
        :name => 'Number of Links to PL Domain',
        :key => :pl_domain_links,
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
      
      :upa => {
        :name => 'Page Strength',
        :key => :page_strength,
        :desc => %Q[The pretty (zero to one hundred, logarithmically scaled) page strength of the target URL],
      },
      :pda => {
        :name => 'Domain Authority',
        :key => :domain_authority,
        :desc => %Q[The pretty (zero to one hundred, logarithmically scaled) domain authority of the target URL's PL domain],
      },
      :upar => {
        :name => 'Page Strength (raw)',
        :key => :page_strength_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) page strength of the target URL],
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
        :key => :t,
        :desc => %Q[The Anchor Text term or phrase],
      },
      :i => {
        :name => 'Internal Target ID',
        :key => :i,
        :desc => %Q[Internal ID of the target URL],
      },
      :iu => {
        :name => 'Internal Pages Linking',
        :key => :iu,
        :desc => %Q[Number of internal pages linking],
      },
      :if => {
        :name => 'Internal Subdomains Linking',
        :key => :if,
        :desc => %Q[Number of internal subdomains linking],
      },
      :eu => {
        :name => 'External Pages Linking',
        :key => :eu,
        :desc => %Q[number of external pages linking],
      },
      :ef => {
        :name => 'External Subdomains Linking',
        :key => :ef,
        :desc => %Q[number of external subdomains linking],
      },
      :ep => {
        :name => 'External Domains Linking',
        :key => :ep,
        :desc => %Q[number of external domains linking],
      },
      :imp => {
        :name => 'Internal mozRank',
        :key => :imp,
        :desc => %Q[sum of internal mozrank],
      },
      :emp => {
        :name => 'External mozRank',
        :key => :emp,
        :desc => %Q[sum of external mozrank],
      },
      :f => {
        :name => 'flags',
        :key => :f,
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

  end
end
