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
        :desc => %Q[the number of external (from other subdomains), juice-passing links to pages on this subdomain]
      },
      :fejp => {
        :name => 'fejp',
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index]
      },
      :fejr => {
        :name => 'fejr',
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the FQ domain of the target URL in the Linkscape index]
      },
      :ff => {
        :name => 'ff',
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the FQ domain of the target URL]
      },
      :fid => {
        :name => 'fid',
        :desc => %Q[The number of domains with at least one link to any page on the FQ domain of the target URL]
      },
      :fjp => {
        :name => 'fjp',
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index]
      },
      :fjr => {
        :name => 'fjr',
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the FQ domain of the target URL in the Linkscape index]
      },
      :fmrp => {
        :name => 'fmrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index]
      },
      :fmrr => {
        :name => 'fmrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the FQ domain of the target URL in the Linkscape index]
      },
      :ftrp => {
        :name => 'ftrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index]
      },
      :ftrr => {
        :name => 'ftrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the FQ domain of the target URL in the Linkscape index]
      },
      :peid => {
        :name => 'peid',
        :desc => %Q[the number of external (from other root domains), juice-passing links to pages on this root domain]
      },
      :pejp => {
        :name => 'pejp',
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index]
      },
      :pejr => {
        :name => 'pejr',
        :desc => %Q[The raw (linearly scaled) sum of the mozRank due to external links of all the pages of the PL domain of the target URL in the Linkscape index]
      },
      :pf => {
        :name => 'pf',
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the PL domain of the target URL]
      },
      :pid => {
        :name => 'pid',
        :desc => %Q[The number of domains with at least one link to any page on the PL domain of the target URL]
      },
      :pjp => {
        :name => 'pjp',
        :desc => %Q[The pretty (logarithmically scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index]
      },
      :pjr => {
        :name => 'pjr',
        :desc => %Q[The raw (linearly scaled) sum of the mozRank of all the pages of the PL domain of the target URL in the Linkscape index]
      },
      :pmrp => {
        :name => 'pmrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the PL domain of target URL in the Linkscape index]
      },
      :pmrr => {
        :name => 'pmrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the PL domain of the target URL in the Linkscape index]
      },
      :ptrp => {
        :name => 'ptrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index]
      },
      :ptrr => {
        :name => 'ptrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the PL domain of the target URL in the Linkscape index]
      },
      :ueid => {
        :name => 'ueid',
        :desc => %Q[The number of external (from other subdomains), juice passing links to the target URL in the Linkscape index]
      },
      :uemrp => {
        :name => 'uemrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the target URL due to external links in the Linkscape index]
      },
      :uemrr => {
        :name => 'uemrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the target URL due to external links in the Linkscape index]
      },
      :uf => {
        :name => 'uf',
        :desc => %Q[The unix timestamp giving a rough idea of how fresh the data is of the target URL]
      },
      :ufq => {
        :name => 'ufq',
        :desc => %Q[The fully qualified domain (FQ domain) as it's identified in the Linkscape index]
      },
      :uid => {
        :name => 'uid',
        :desc => %Q[The number of internal and external, juice and non-juice passing links to the target URL in the Linkscape index]
      },
      :uifq => {
        :name => 'uifq',
        :desc => %Q[The number of FQ domains with at least one link to the target URL in the Linkscape index]
      },
      :uipl => {
        :name => 'uipl',
        :desc => %Q[The number of PL domains with at least one link to the target URL in the Linkscape index]
      },
      :ujid => {
        :name => 'ujid',
        :desc => %Q[The number of juice passing links (internal or external) to the target URL in the Linkscape index]
      },
      :umrp => {
        :name => 'umrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank of the target URL in the Linkscape index]
      },
      :umrr => {
        :name => 'umrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank of the target URL in the Linkscape index]
      },
      :upl => {
        :name => 'upl',
        :desc => %Q[The pay-level domain (PL domain) as it's identified in the Linkscape index]
      },
      :ur => {
        :name => 'ur',
        :desc => %Q[If the URL in question performs some kind of search engine canonicalization that is known to Linkscape (e.g., a 301 redirect), this field will contain the target of the canonicalization]
      },
      :urid => {
        :name => 'urid',
        :desc => %Q[Internal ID of the URL]
      },
      :urrid => {
        :name => 'urrid',
        :desc => %Q[Internal ID of the canonical URL]
      },
      :us => {
        :name => 'us',
        :desc => %Q[The HTTP status of the target URL]
      },
      :ut => {
        :name => 'ut',
        :desc => %Q[The title of the target URL, if a title is available]
      },
      :utrp => {
        :name => 'utrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozTrust of the target URL in the Linkscape index]
      },
      :utrr => {
        :name => 'utrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozTrust of the target URL in the Linkscape index]
      },
      :uu => {
        :name => 'uu',
        :desc => %Q[The URL in question, as it has been canonicalized in the Linkscape index]
      },
    }

    LinkResponseFields = {
      # Link metric responses
      :lt => {
        :name => 'lt',
        :desc => %Q[The anchor text of the link, including any markup (e.g. image tags with alt text)]
      },
      :lsrc => {
        :name => 'lsrc',
        :desc => %Q[Internal ID of the source URL]
      },
      :lrid => {
        :name => 'lrid',
        :desc => %Q[Internal ID of the link]
      },
      :ltgt => {
        :name => 'ltgt',
        :desc => %Q[Internal ID of the target URL]
      },
      :lf => {
        :name => 'lf',
        :desc => %Q[A bit field indicating link attributes that apply to this link]
      },
      :lmrr => {
        :name => 'lmrr',
        :desc => %Q[The raw (zero to one, linearly scaled) measure of the mozRank passed to the target of this link]
      },
      :lmrp => {
        :name => 'lmrp',
        :desc => %Q[The pretty (ten point, logarithmically scaled) measure of the mozRank passed to the target URL in the Linkscape index]
      },
    }
    
    ResponseFields = {}
    URLResponseFields.each {|k,v| ResponseFields["lu#{k}".to_sym] = v.dup.merge(:desc => "#{v[:desc]} (Target)")}
    ResponseFields.merge!(URLResponseFields)
    ResponseFields.merge!(LinkResponseFields)
  end
end
