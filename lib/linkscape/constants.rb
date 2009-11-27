directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'constants', 'anchor-metrics')
require File.join(directory, 'constants', 'url-metrics')
require File.join(directory, 'constants', 'link-metrics')

module Linkscape
  module Constants
    URLResponseFields = {

      # URL metric responses
      :feid => {
        :source => :feid,
        :name => 'feid',
        :key => :feid,
        :desc => %Q[the number of external (from other subdomains), juice-passing links to pages on this subdomain],
        :subject => :source,
      },
      :fejp => {
        :source => :fejp,
        :name => 'fejp',
        :key => :fejp,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :fejr => {
        :source => :fejr,
        :name => 'fejr',
        :key => :fejr,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :ff => {
        :source => :ff,
        :name => 'ff',
        :key => :ff,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the FQ domain of the target URL],
        :subject => :source,
      },
      :fid => {
        :source => :fid,
        :name => 'fid',
        :key => :fid,
        :desc => %Q[The number of domains with at least one link to any page on the FQ domain of the target URL],
        :subject => :source,
      },
      :fjp => {
        :source => :fjp,
        :name => 'fjp',
        :key => :fjp,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :fjr => {
        :source => :fjr,
        :name => 'fjr',
        :key => :fjr,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :fmrp => {
        :source => :fmrp,
        :name => 'fmrp',
        :key => :fmrp,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :fmrr => {
        :source => :fmrr,
        :name => 'fmrr',
        :key => :fmrr,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :ftrp => {
        :source => :ftrp,
        :name => 'ftrp',
        :key => :ftrp,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :ftrr => {
        :source => :ftrr,
        :name => 'ftrr',
        :key => :ftrr,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :peid => {
        :source => :peid,
        :name => 'peid',
        :key => :peid,
        :desc => %Q[the number of external (from other root domains), juice-passing links to pages on this root domain],
        :subject => :source,
      },
      :pejp => {
        :source => :pejp,
        :name => 'pejp',
        :key => :pejp,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :pejr => {
        :source => :pejr,
        :name => 'pejr',
        :key => :pejr,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :pf => {
        :source => :pf,
        :name => 'Time of Last PL Domain Update',
        :key => :pl_domain_updated_at,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the PL domain of the target URL],
        :subject => :source,
      },
      :pid => {
        :source => :pid,
        :name => 'Number of Links to PL Domain',
        :key => :pl_domain_links,
        :desc => %Q[The number of domains with at least one link to any page on the PL domain of the target URL],
        :subject => :source,
      },
      :pjp => {
        :source => :pjp,
        :name => 'mozRank sum of all PL Domain Pages',
        :key => :pl_domain_mozrank_sum,
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :pjr => {
        :source => :pjr,
        :name => 'mozRank sum of all PL Domain Pages (raw)',
        :key => :pl_domain_mozrank_sum_raw,
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :pmrp => {
        :source => :pmrp,
        :name => 'mozRank of PL Domain',
        :key => :pl_domain_mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the PL domain of target URL in the Linkscape index],
        :subject => :source,
      },
      :pmrr => {
        :source => :pmrr,
        :name => 'mozRank of PL Domain (raw)',
        :key => :pl_domain_mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the PL domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :ptrp => {
        :source => :ptrp,
        :name => 'mozTrust of PL Domain',
        :key => :pl_domain_moztrust,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :ptrr => {
        :source => :ptrr,
        :name => 'mozTrust of PL Domain (raw)',
        :key => :pl_domain_moztrust_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index],
        :subject => :source,
      },
      :ueid => {
        :source => :ueid,
        :name => 'Number of External Juice-Passing Links',
        :key => :external_links,
        :desc => %Q[The number of external (from other subdomains), juice passing links to the target URL in the Linkscape index],
        :subject => :source,
      },
      :uemrp => {
        :source => :uemrp,
        :name => 'External mozRank',
        :key => :external_mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the target URL due to external links in the Linkscape index],
        :subject => :source,
      },
      :uemrr => {
        :source => :uemrr,
        :name => 'External mozRank (raw)',
        :key => :external_mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the target URL due to external links in the Linkscape index],
        :subject => :source,
      },
      :uf => {
        :source => :uf,
        :name => 'Time of Last Update',
        :key => :updated_at,
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the target URL],
        :subject => :source,
      },
      :ufq => {
        :source => :ufq,
        :name => 'Fully-Qualified Domain',
        :key => :fq_domain,
        :desc => %Q[The fully qualified domain (FQ domain) as it's identified in the Linkscape index],
        :subject => :source,
      },
      :uid => {
        :source => :uid,
        :name => 'Number of Links',
        :key => :links,
        :desc => %Q[The number of internal and external, juice and non-juice passing links to the target URL in the Linkscape index],
        :subject => :source,
      },
      :uifq => {
        :source => :uifq,
        :name => 'Nunber of FQ Domains Linking',
        :key => :fq_domains_linking,
        :desc => %Q[The number of FQ domains with at least one link to the target URL in the Linkscape index],
        :subject => :source,
      },
      :uipl => {
        :source => :uipl,
        :name => 'Number of PL Domains Linking',
        :key => :pl_domains_linking,
        :desc => %Q[The number of PL domains with at least one link to the target URL in the Linkscape index],
        :subject => :source,
      },
      :ujid => {
        :source => :ujid,
        :name => 'Juice-passing Links',
        :key => :juice_links,
        :desc => %Q[The number of juice passing links (internal or external) to the target URL in the Linkscape index],
        :subject => :source,
      },
      :umrp => {
        :source => :umrp,
        :name => 'mozRank',
        :key => :mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the target URL in the Linkscape index],
        :subject => :source,
      },
      :umrr => {
        :source => :umrr,
        :name => 'mozRank (raw)',
        :key => :mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the target URL in the Linkscape index],
        :subject => :source,
      },
      :upl => {
        :source => :upl,
        :name => 'Pay-Level Domain',
        :key => :pl_domain,
        :desc => %Q[The pay-level domain (PL domain) as it's identified in the Linkscape index],
        :subject => :source,
      },
      :ur => {
        :source => :ur,
        :name => 'Canonical URL',
        :key => :canonical_url,
        :desc => %Q[If the URL in question performs some kind of search engine canonicalization that is known to Linkscape (e.g., a 301 redirect), this field will contain the target of the canonicalization],
        :subject => :source,
      },
      :urid => {
        :source => :urid,
        :name => 'Internal ID',
        :key => :internal_id,
        :desc => %Q[Internal ID of the URL],
        :subject => :source,
      },
      :urrid => {
        :source => :urrid,
        :name => 'Canonical URL Internal ID',
        :key => :canonical_internal_id,
        :desc => %Q[Internal ID of the canonical URL],
        :subject => :source,
      },
      :us => {
        :source => :us,
        :name => 'HTTP Status',
        :key => :status,
        :desc => %Q[The HTTP status of the target URL],
        :subject => :source,
      },
      :ut => {
        :source => :ut,
        :name => 'Page Title',
        :key => :title,
        :desc => %Q[The title of the target URL, if a title is available],
        :subject => :source,
      },
      :utrp => {
        :source => :utrp,
        :name => 'mozTrust',
        :key => :moztrust,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the target URL in the Linkscape index],
        :subject => :source,
      },
      :utrr => {
        :source => :utrr,
        :name => 'mozTrust (raw)',
        :key => :moztrust_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the target URL in the Linkscape index],
        :subject => :source,
      },
      :uu => {
        :source => :uu,
        :name => 'URL',
        :key => :url,
        :desc => %Q[The URL in question, as it has been canonicalized in the Linkscape index],
        :subject => :source,
      },
    }

    LinkResponseFields = {
      # Link metric responses
      :lt => {
        :source => :lt,
        :name => 'Anchor Text',
        :key => :text,
        :desc => %Q[The anchor text of the link, including any markup (e.g. image tags with alt text)],
        :subject => :link,
      },
      :lsrc => {
        :source => :lsrc,
        :name => 'Source Internal ID',
        :key => :source_internal_id,
        :desc => %Q[Internal ID of the source URL],
        :subject => :link,
      },
      :lrid => {
        :source => :lrid,
        :name => 'Link Internal ID',
        :key => :internal_id,
        :desc => %Q[Internal ID of the link],
        :subject => :link,
      },
      :ltgt => {
        :source => :ltgt,
        :name => 'Target Internal ID',
        :key => :target_internal_id,
        :desc => %Q[Internal ID of the target URL],
        :subject => :link,
      },
      :lf => {
        :source => :lf,
        :name => 'Link Flags',
        :key => :flags,
        :desc => %Q[A bit field indicating link attributes that apply to this link],
        :subject => :link,
      },
      :lmrr => {
        :source => :lmrr,
        :name => 'mozRank Passed (raw)',
        :key => :mozrank_raw,
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank passed to the target of this link],
        :subject => :link,
      },
      :lmrp => {
        :source => :lmrp,
        :name => 'mozRank Passed',
        :key => :mozrank,
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank passed to the target URL in the Linkscape index],
        :subject => :link,
      },
    }
    
    ResponseFields = {}
    URLResponseFields.each {|k,v| ResponseFields["lu#{k}".to_sym] = v.dup.merge(:desc => "#{v[:desc]} (Target)", :source => "lu#{k}".to_sym, :subject => :target)}
    URLResponseFields.each {|k,v| URLResponseFields[v[:key]]=v if v[:key] }
    LinkResponseFields.each {|k,v| URLResponseFields[v[:key]]=v if v[:key] }
    ResponseFields.merge!(URLResponseFields)
    ResponseFields.merge!(LinkResponseFields)
  end
end
