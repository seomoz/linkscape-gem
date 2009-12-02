directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'constants', 'anchor-metrics')
require File.join(directory, 'constants', 'url-metrics')
require File.join(directory, 'constants', 'link-metrics')

module Linkscape
  module Constants
    URLResponseFields = {

      # URL metric responses
      :feid => {
        :name => 'feid',
        :key => :feid,
        :desc => %Q[the number of external (from other subdomains), juice-passing links to pages on this subdomain],
      },
      :fejp => {
        :name => 'fejp',
        :key => :fejp,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :fejr => {
        :name => 'fejr',
        :key => :fejr,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :ff => {
        :name => 'ff',
        :key => :ff,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the FQ domain of the target URL],
      },
      :fid => {
        :name => 'fid',
        :key => :fid,
        :desc => %Q[The number of domains with at least one link to any page on the FQ domain of the target URL],
      },
      :fjp => {
        :name => 'fjp',
        :key => :fjp,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :fjr => {
        :name => 'fjr',
        :key => :fjr,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index],
      },
      :fmrp => {
        :name => 'fmrp',
        :key => :fmrp,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index],
      },
      :fmrr => {
        :name => 'fmrr',
        :key => :fmrr,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index],
      },
      :ftrp => {
        :name => 'ftrp',
        :key => :ftrp,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index],
      },
      :ftrr => {
        :name => 'ftrr',
        :key => :ftrr,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index],
      },
      :peid => {
        :name => 'peid',
        :key => :peid,
        :desc => %Q[the number of external (from other root domains), juice-passing links to pages on this root domain],
      },
      :pejp => {
        :name => 'pejp',
        :key => :pejp,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index],
      },
      :pejr => {
        :name => 'pejr',
        :key => :pejr,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index],
      },
      :pf => {
        :name => 'Time of Last PL Domain Update',
        :key => :pl_domain_updated_at,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the PL domain of the target URL],
      },
      :pid => {
        :name => 'Number of Links to PL Domain',
        :key => :pl_domain_links,
        :desc => %Q[The number of domains with at least one link to any page on the PL domain of the target URL],
      },
      :pjp => {
        :name => 'mozRank sum of all PL Domain Pages',
        :key => :pl_domain_mozrank_sum,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index],
      },
      :pjr => {
        :name => 'mozRank sum of all PL Domain Pages (raw)',
        :key => :pl_domain_mozrank_sum_raw,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index],
      },
      :pmrp => {
        :name => 'mozRank of PL Domain',
        :key => :pl_domain_mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the PL domain of target URL in the Linkscape index],
      },
      :pmrr => {
        :name => 'mozRank of PL Domain (raw)',
        :key => :pl_domain_mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the PL domain of the target URL in the Linkscape index],
      },
      :ptrp => {
        :name => 'mozTrust of PL Domain',
        :key => :pl_domain_moztrust,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index],
      },
      :ptrr => {
        :name => 'mozTrust of PL Domain (raw)',
        :key => :pl_domain_moztrust_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index],
      },
      :ueid => {
        :name => 'Number of External Juice-Passing Links',
        :key => :external_links,
        :desc => %Q[The number of external (from other subdomains), juice passing links to the target URL in the Linkscape index],
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
      :uf => {
        :name => 'Time of Last Update',
        :key => :updated_at,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the target URL],
      },
      :ufq => {
        :name => 'Fully-Qualified Domain',
        :key => :fq_domain,
        :desc => %Q[The fully qualified domain (FQ domain) as it's identified in the Linkscape index],
      },
      :uid => {
        :name => 'Number of Links',
        :key => :links,
        :desc => %Q[The number of internal and external, juice and non-juice passing links to the target URL in the Linkscape index],
      },
      :uifq => {
        :name => 'Nunber of FQ Domains Linking',
        :key => :fq_domains_linking,
        :desc => %Q[The number of FQ domains with at least one link to the target URL in the Linkscape index],
      },
      :uipl => {
        :name => 'Number of PL Domains Linking',
        :key => :pl_domains_linking,
        :desc => %Q[The number of PL domains with at least one link to the target URL in the Linkscape index],
      },
      :ujid => {
        :name => 'Juice-passing Links',
        :key => :juice_links,
        :desc => %Q[The number of juice passing links (internal or external) to the target URL in the Linkscape index],
      },
      :umrp => {
        :name => 'mozRank',
        :key => :mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the target URL in the Linkscape index],
      },
      :umrr => {
        :name => 'mozRank (raw)',
        :key => :mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the target URL in the Linkscape index],
      },
      :upl => {
        :name => 'Pay-Level Domain',
        :key => :pl_domain,
        :desc => %Q[The pay-level domain (PL domain) as it's identified in the Linkscape index],
      },
      :ur => {
        :name => 'Canonical URL',
        :key => :canonical_url,
        :desc => %Q[If the URL in question performs some kind of search engine canonicalization that is known to Linkscape (e.g., a 301 redirect), this field will contain the target of the canonicalization],
      },
      :urid => {
        :name => 'Internal ID',
        :key => :internal_id,
        :desc => %Q[Internal ID of the URL],
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
      :utrp => {
        :name => 'mozTrust',
        :key => :moztrust,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the target URL in the Linkscape index],
      },
      :utrr => {
        :name => 'mozTrust (raw)',
        :key => :moztrust_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the target URL in the Linkscape index],
      },
      :uu => {
        :name => 'URL',
        :key => :url,
        :desc => %Q[The URL in question, as it has been canonicalized in the Linkscape index],
      },
    }
    URLResponsePrefixes = {
      nil  => :source,
      :lu  => :target,
    }


    LinkResponseFields = {
      # Link metric responses
      :t => {
        :name => 'Anchor Text',
        :key => :text,
        :desc => %Q[The anchor text of the link, including any markup (e.g. image tags with alt text)],
        :subject => :link,
      },
      :src => {
        :name => 'Source Internal ID',
        :key => :source_internal_id,
        :desc => %Q[Internal ID of the source URL],
        :subject => :link,
      },
      :rid => {
        :name => 'Link Internal ID',
        :key => :internal_id,
        :desc => %Q[Internal ID of the link],
        :subject => :link,
      },
      :tgt => {
        :name => 'Target Internal ID',
        :key => :target_internal_id,
        :desc => %Q[Internal ID of the target URL],
        :subject => :link,
      },
      :f => {
        :name => 'Link Flags',
        :key => :flags,
        :desc => %Q[A bit field indicating link attributes that apply to this link],
        :subject => :link,
        :bitfield => :link,
      },
      :mrr => {
        :name => 'mozRank Passed (raw)',
        :key => :mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank passed to the target of this link],
        :subject => :link,
      },
      :mrp => {
        :name => 'mozRank Passed',
        :key => :mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank passed to the target URL in the Linkscape index],
        :subject => :link,
      },
    }
    LinkResponsePrefixes = {
      :l   => :link,
    }


    AnchorResponseFields = {
      :pt => {
        :name => 'Anchor Text',
        :key => :pt,
        :desc => %Q[The Anchor Text term or phrase],
      },
      :pi => {
        :name => 'Internal Target ID',
        :key => :pi,
        :desc => %Q[Internal ID of the target URL],
      },
      :piu => {
        :name => 'Internal Pages Linking',
        :key => :piu,
        :desc => %Q[Number of internal pages linking],
      },
      :pif => {
        :name => 'Internal Subdomains Linking',
        :key => :pif,
        :desc => %Q[Number of internal subdomains linking],
      },
      :peu => {
        :name => 'External Pages Linking',
        :key => :peu,
        :desc => %Q[number of external pages linking],
      },
      :pef => {
        :name => 'External Subdomains Linking',
        :key => :pef,
        :desc => %Q[number of external subdomains linking],
      },
      :pep => {
        :name => 'External Domains Linking',
        :key => :pep,
        :desc => %Q[number of external domains linking],
      },
      :pimp => {
        :name => 'Internal mozRank',
        :key => :pimp,
        :desc => %Q[sum of internal mozrank],
      },
      :pemp => {
        :name => 'External mozRank',
        :key => :pemp,
        :desc => %Q[sum of external mozrank],
      },
      :pf => {
        :name => 'flags',
        :key => :pf,
        :desc => %Q[Flags],
      },
    }
    AnchorResponsePrefixes = {
      :app => :anchor1,
      :apf => :anchor2,
      :apu => :anchor3,
      :atp => :anchor4,
      :atf => :anchor5,
      :atu => :anchor6,
    }


    ResponseFields = {}
    # URLResponseFields.each {|k,v| ResponseFields["lu#{k}".to_sym] = v.dup.merge(:desc => "#{v[:desc]} (Target)", :source => "lu#{k}".to_sym, :subject => :target)}
    # ResponseFields.keys.each {|k| ResponseFields[ResponseFields[k][:key]]=ResponseFields[k] if ResponseFields[k][:key] }

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
  end
end
