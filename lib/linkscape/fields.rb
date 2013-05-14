##
# Abstract away all the obscurity of the raw linkscape API data. Incoming data comes in as key/value pairs.
# The keys are extremely abstract and appear to be completely random. This class provides a mapping from
# the abstract names to names that are a little more human readable.
#
class Linkscape::Fields

  HUMAN = {
    :internal_id => {
      :name => 'Internal ID',
      :flag => 1,
      :key => :lrid,
      :desc => %Q[The internal ID]
    },
    :title => {
      :name => 'Title',
      :flag => 2**0, # 1,
      :key  => :ut,
      :desc => %Q[The title of the page if available. For example: "Request-Response Format"]
    },
    :nofollow? => {
      :name => "Is No Follow?",
      :flag => 2**0,
      :desc => %Q[The link in question bore a "rel=nofollow" directive indicating that no juice should flow over the link.]
    },
    :anchors_anchor_text => {
      :name => "Anchor Text",
      :flag => 2**1,
      :key => :atut,
      :desc => %Q[The anchor text term or phrase]
    },
    :same_sub_domain? => {
      :name => "Is Same Sub Domain?",
      :flag => 2**1,
      :desc => %Q[The link is between two pages on the same domain.]
    },
    :url => {
      :name => "URL",
      :flag => 2**2,
      :desc => %Q[The url of the page.  For example: "apiwiki.seomoz.org/Request-Response+Format"]
    },
    :meta_refresh? => {
      :name => "Has Meta-Refresh?",
      :flag => 2**2,
      :desc => %Q[The link is actually a meta refresh from the source page to the target]
    },
    :num_internal_page_links_with_anchor => {
      :name => "Internal Pages Linking",
      :flag => 2**3,
      :key => :atuiu,
      :desc => %Q[The number of internal pages linking with this term or phrase]
    },
    :same_ip? => {
      :name => "Has Same IP?",
      :flag => 2**3,
      :desc => %Q[The link is between two pages hosted on the same IP address, strongly indicating a potential administrative relationship between the two.]
    },
    :num_subdomains_on_domain_with_anchor_text => {
      :name => "Internal Subdomains Linking",
      :flag => 2**4,
      :key => :atuif,
      :desc => %Q[The number of subdomains on the same root domain with at least one link with this term or phrase"]
    },
    :same_cblock? => {
      :name => "Has Same C-Block?",
      :flag => 2**4,
      :desc => %Q[The link is between two pages hosted on the same C Block of IP addresses, indicating a potential administrative relationship between the two.]
    },
    :anchors_num_external_subdomains_linking => {
      :name => "External Subdomains Linking",
      :flag => 2**6,
      :key => :atuef,
      :desc => %Q[The number of external subdomains with at least one link with this term or phrase]
    },
    :http_301? => {
      :name => "Is 301 Redirect?",
      :flag => 2**6,
      :desc => %Q[The link is a 301 redirect.  The source page returned a 301 redirect to our crawler, indicating that the resource was available on the target.]
    },
    :http_302? => {
      :name => "Is 302 Redirect?",
      :flag => 2**7,
      :desc => %Q[The link is a 302 redirect.  The source page returned a 302 redirect to our crawler, indicating that the resource was temporarily available on the target.]
    },
    :anchors_internal_mozrank_passed => {
      :name => "Internal mozRank passed",
      :flag => 2**8,
      :key => :atuimp,
      :desc => %Q[The amount of mozRank passed over all internal links with this term or phrase (on the 10 point scale)]
    },
    :noscript? => {
      :name => "Appears in noscript",
      :flag => 2**8,
      :desc => %Q[The link was located within a noscript html block. This means the link may not have been visible to users using javascript.]
    },
    :anchors_external_mozrank_passed => {
      :name => "External mozRank passed",
      :flag => 2**9,
      :key => :atuemp,
      :desc => %Q[The amount of mozRank passed over all external links with this term or phrase (on the 10 point scale)]
    },
    :off_screen? => {
      :name => "Appears Off-Screen",
      :flag => 2**9,
      :desc => %Q[We determined that the link likely appears offscreen.  This means that the link may not have been visible to most users.]
    },
    :meta_nofollow? => {
      :name => "Has Meta Nofollow",
      :flag => 2**11,
      :desc => %Q[The link appeared on a page using a page level (meta) no follow directive.  This link passes no juice.]
    },
    :same_root_domain? => {
      :name => "Has Same Root Domain?",
      :flag => 2**12,
      :desc => %Q[The link is between two pages on the same root domain.  The link is internal, and strongly indicates an administrative relationship between the two pages.]
    },
    :feed? => {
      :name => "Is Syndication Feed?",
      :flag => 2**14,
      :desc => %Q[The link indicates a syndication feed (e.g. rss or atom) for the source page.]
    },
    :rel_canonical? => {
      :name => "Is Rel Canonical",
      :flag => 2**15,
      :desc => %Q[The link indicates a canonical form of the page using the rel=canonical directive.]
    },
    :via_301? => {
      :name => "Is Found via 301?",
      :flag => 2**16,
      :desc => %Q[The source page actually links to some other URL which redirects via a 301 to the target page.]
    },
    :flags => {
      :name => 'Flags',
      :flag => 2**1, # 2
      :key => :lf,
      :desc => %Q[A bit field indicating a variety of attributes which apply to this link.]
    },
    :anchor_text => {
      :name => 'Anchor Text',
      :flag => 2**2, # 4,
      :key  => :lt,
      :desc => %Q[The anchor text of the link, including any markup (e.g. image tags with alt text).]
    },
    :canonical_source_url => {
      :name => 'URL',
      :flag => 2**2, # 4,
      :key  => :uu,
      :desc => %Q[The url of the page.  For example: "apiwiki.seomoz.org/Request-Response+Format"]
    },
    :canonical_target_url => {
      :name => "Canonical Target URL",
      :flag => 2**2,
      :key => :luuu,
      :desc => %Q[The URL in question, as it has been canonicalized in the Linkscape index (Target)]
    },
    :normalized_anchor_text => {
      :name => 'Normalized Anchor Text',
      :flag => 2**3,
      :key => :lnt,
      :desc => %Q[The anchor text of the link, excluding markup]
    },
    :subdomain => {
      :name => 'Subdomain of the URL',
      :flag => 2**3,
      :key => :ufq,
      :desc => %Q[The subdomain of the url.  For example: "apiwiki.seomoz.org"]
    },
    :root_domain => {
      :name => 'Root Domain',
      :flag => 2**4,
      :key => :upl,
      :desc => %Q[The root domain of the url.  For example: "seomoz.org"]
    },
    :mozrank_passed_to_target => {
      :name => "MozRank Passed to Target URL",
      :flag => 2**4,
      :key => :lmrp,
      :desc => %Q[The measure of the mozRank passed to the target URL. Requesting this metric will provide both the pretty 10-point score (lmrp) and the raw score (lmrr).]
    },
    :mozrank_passed_to_target_raw => {
      :name => "MozRank Passed to Target URL",
      :flag => 2**4,
      :key => :lmrr,
      :desc => %Q[The measure of the mozRank passed to the target URL. Requesting this metric will provide both the pretty 10-point score (lmrp) and the raw score (lmrr).]
    },
    :num_external_follow_links_to_page => {
      :name => 'Number of External Juice Passing Links',
      :flag => 2**5,
      :key => :ueid,
      :desc => %Q[The number of juice-passing external links to the url.]
    },
    :num_external_page_links_with_anchor => {
      :name => "Numbers of Pages with the Anchor",
      :flag => 2**5,
      :key  => :atueu
    },
    :num_external_follow_links_to_subdomain => {
      :name => 'Number of Links from External pages to Subdomain',
      :flag => 2**6,
      :key => :feid,
      :desc => %Q[The number of juice-passing external links to the subdomain of the url.]
    },
    :num_external_follow_links_to_domain => {
      :name => 'Number of External Juice Links Linking to Root Domain',
      :flag => 2**7,
      :key => :peid,
      :desc => %Q[The number of juice-passing external links to the root domain of the url.]
    },
    :num_external_root_domain_links_with_anchor => {
      :name => "Number of Domains using this Anchor Text",
      :flag => 2**7,
      :key => :atuep
    },
    :num_follow_links_to_page => {
      :name => 'Number of Juice Passing Links Linking',
      :flag => 2**8,
      :key => :ujid,
      :desc => %Q[The number of juice-passing links (internal or external) to the url.]
    },
    :num_subdomain_links => {
      :name => 'Number of Subdomains Linking',
      :flag => 2**9,
      :key => :uifq,
      :desc => %Q[The subdomain of the url.  For example: "apiwiki.seomoz.org"]
    },
    :num_root_domain_links_to_page => {
      :name => 'Root Domains Linking',
      :flag => 2**10, # 1024,
      :key => :uipl,
      :desc => %Q[The number of root domains with any pages linking to the url.]
    },
    :anchor_flags => {
      :name => "Anchor Flags",
      :flag => 2**10,
      :desc => %Q[Get any anchor flags available]
    },
    :num_links => {
      :name => 'Number of Links',
      :flag => 2**11,
      :key => :uid,
      :desc => %Q[The number of links (juice-passing or not, internal or external) to the url.]
    },
    :num_subdomain_links_to_subdomain => {
      :name => 'Number of subdomains linking to this subdomain',
      :flag => 2**12,
      :key => :fid,
      :desc => %Q[The number of subdomains with any pages linking to the subdomain of the url.]
    },
    :num_domain_links_to_domain=> {
      :name => 'Number of Root Domains Linking to Root Domain',
      :flag => 2**13,
      :key => :pid,
      :desc => %Q[The number of root domains with any pages linking to the root domain of the url.]
    },
    :mozrank => {
      :name => 'MozRank',
      :flag => 2**14,
      :key => :umrp,
      :desc => %Q[The mozRank of the url.  Requesting this metric will provide both the pretty 10-point score (in umrp) and the raw score (umrr).]
    },
    :mozrank_raw => {
      :name => 'Raw MozRank',
      :flag => 2**14,
      :key => :umrr,
      :desc => %Q[The mozRank of the url.  Requesting this metric will provide both the pretty 10-point score (in umrp) and the raw score (umrr).]
    },
    :subdomain_mozrank => {
      :name => 'MozRank of the Subdomain',
      :flag => 2**15,
      :key => :fmrp,
      :desc => %Q[The mozRank of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score (fmrp) and the raw score (fmrr).]
    },
    :subdomain_mozrank_raw => {
      :name => 'Raw MozRank of the Subdomain',
      :flag => 2**15,
      :key => :fmrr,
      :desc => %Q[The mozRank of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score (fmrp) and the raw score (fmrr).]
    },
    :root_domain_mozrank => {
      :name => 'Mozrank of Root Domain',
      :flag => 2**16,
      :key => :pmrp,
      :desc => %Q[The mozRank of the Root Domain of the url.  Requesting this metric will provide both the pretty 10-point score (pmrp) and the raw score (pmrr).]
    },
    :root_domain_mozrank_raw => {
      :name => 'Raw Mozrank of Root Domain',
      :flag => 2**16,
      :key => :pmrr,
      :desc => %Q[The mozRank of the Root Domain of the url.  Requesting this metric will provide both the pretty 10-point score (pmrp) and the raw score (pmrr).]
    },
    :moztrust => {
      :name => 'MozTrust of the URL',
      :flag => 2**17,
      :key => :utrp,
      :desc => %Q[The mozTrust of the url.    Requesting this metric will provide both the pretty 10-point score (utrp) and the raw score (utrr).]
    },
    :moztrust_raw => {
      :name => 'Raw MozTrust of the URL',
      :flag => 2**17,
      :key => :utrr,
      :desc => %Q[The mozTrust of the url.    Requesting this metric will provide both the pretty 10-point score (utrp) and the raw score (utrr).]
    },
    :subdomain_moztrust => {
      :name => 'MozTrust of the Subdomain',
      :flag => 2**18,
      :key => :ftrp,
      :desc => %Q[The mozTrust of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score (ftrp) and the raw score (ftrr).]
    },
    :subdomain_moztrust_raw => {
      :name => 'Raw MozTrust of the Subdomain',
      :flag => 2**18,
      :key => :ftrr,
      :desc => %Q[The mozTrust of the subdomain of the url.  Requesting this metric will provide both the pretty 10-point score (ftrp) and the raw score (ftrr).]
    },
    :root_domain_moztrust => {
      :name => 'MozTrust of Root Domain',
      :flag => 2**19,
      :key => :ptrp,
      :desc => %Q[The mozTrust of the root domain of the url.  Requesting this metric will provide both the pretty 10-point score (ptrp) and the raw score (ptrr).]
    },
    :root_domain_moztrust_raw => {
      :name => 'Raw MozTrust of Root Domain',
      :flag => 2**19,
      :key => :ptrr,
      :desc => %Q[The mozTrust of the root domain of the url.  Requesting this metric will provide both the pretty 10-point score (ptrp) and the raw score (ptrr).]
    },
    :external_mozrank => {
      :name => 'External MozRank',
      :flag => 2**20,
      :key => :uemrp,
      :desc => %Q[The portion of the url's mozRank coming from external links.  Requesting this metric will provide both the pretty 10-point score (uemrp) and the raw score (uemrr).]
    },
    :external_mozrank_raw => {
      :name => 'Raw External MozRank',
      :flag => 2**20,
      :key => :uemrr,
      :desc => %Q[The portion of the url's mozRank coming from external links.  Requesting this metric will provide both the pretty 10-point score (uemrp) and the raw score (uemrr).]
    },
    :subdomain_external_domain_juice => {
      :name => 'Subdomain External Domain Juice',
      :flag => 2**21,
      :key  => :fejp,
      :desc => %Q[The portion of the mozRank of all pages on the subdomain coming from external links.  Requesting this metric will provide both the pretty 10-point score (fejp) and the raw score (fejr).]
    },
    :subdomain_external_domain_juice_raw => {
      :name => 'Subdomain External Domain Juice Raw',
      :flag => 2**21,
      :key => :fejr,
      :desc => %Q[The portion of the mozRank of all pages on the subdomain coming from external links.  Requesting this metric will provide both the pretty 10-point score (fejp) and the raw score (fejr).]
    },
    :root_domain_external_juice => {
      :name => 'Root Domain External Juice',
      :flag => 2**22,
      :key => :pejp,
      :desc => %Q[The portion of the mozRank of all pages on the root domain coming from external links.  Requesting this metric will provide both the pretty 10-point score (pejp) and the raw score (pejr).]
    },
    :root_domain_external_juice_raw => {
      :name => 'Root Domain External Juice Raw',
      :flag => 2**22,
      :key => :pejr,
      :desc => %Q[The portion of the mozRank of all pages on the root domain coming from external links.  Requesting this metric will provide both the pretty 10-point score (pejp) and the raw score (pejr).]
    },
    :sub_domain_juice => {
      :name => 'Subdomain Juice',
      :flag => 2**23,
      :key => :fjp,
      :desc => %Q[The mozRank of all pages on the subdomain combined.  Requesting this metric will provide both the pretty 10-point score (fjp) and the raw score (fjr).]
    },
    :sub_domain_juice_raw => {
      :name => 'Subdomain Juice Raw',
      :flag => 2**23,
      :key => :fjr,
      :desc => %Q[The mozRank of all pages on the subdomain combined.  Requesting this metric will provide both the pretty 10-point score (fjp) and the raw score (fjr).]
    },
    :root_domain_juice => {
      :name => 'Root Domain Juice',
      :flag => 2**24,
      :key => :pjp,
      :desc => %Q[The mozRank of all pages on the root domain combined.  Requesting this metric will provide both the pretty 10-point score (pjp) and the raw score (pjr).]
    },
    :root_domain_juice_raw => {
      :name => 'Raw Root Domain Juice',
      :flag => 2**24,
      :key => :pjr,
      :desc => %Q[The mozRank of all pages on the root domain combined.  Requesting this metric will provide both the pretty 10-point score (pjp) and the raw score (pjr).]
    },
    :canonical_url => {
      :name => 'Canonical URL',
      :flag => 2**28,
      :key => :ur,
      :desc => %Q[If the url canaonicalizes to a different form, that canonical form will be available in this field.]
    },
    :http_status_code => {
      :name => 'HTTP Status Code',
      :flag => 2**29,
      :key => :us,
      :desc => %Q[The HTTP status code recorded by Linkscape for this URL (if available)]
    },
    :num_links_to_subdomain => {
      :name => "Number of Links to Subdomain",
      :flag => 2**32,
      :key => :fuid,
      :desc => %Q[Total links (including internal and nofollow links) to the subdomain of the url in question.]
    },
    :num_links_to_domain => {
      :name => "Number of Links to Root Domain",
      :flag => 2**33,
      :key => :puid,
      :desc => %Q[Total links (including internal and nofollow links) to the root domain of the url in question.]
    },
    :num_domain_links_to_subdomain => {
      :name => "Number of domain links to any page on the subdomain",
      :flag => 2**34,
      :key  => :fipl,
      :desc => %Q[The number of root domains with at least one link to the subdomain of the url in question.]
    },
    :page_authority => {
      :name => 'Page Authority',
      :flag => 2**35, # 34359738368,
      :key  => :upa,
      :desc => %Q[The page authority of this URL. This will return the pretty 100-point score.]
    },
    :domain_authority => {
      :name => 'Domain Authority',
      :flag => 2**36, # 68719476736,
      :key  => :pda,
      :desc => %Q[The page authority of all pages on the root domain. This will return the pretty 100-point score.]
    },
    :page_authority_raw => {
      :name => 'Raw Page Authority',
      :flag => 2**37,
      :key => :upar,
      :desc => %Q[The raw page authority of this URL. This will return the zero to one linear value.]
    },
    :domain_authority_raw => {
      :name => 'Raw domain authority',
      :flag => 2**38,
      :key => :pdar,
      :desc => %Q[The raw page authority of all pages on the root domain. This will return the zero to one linear value.]
    },
    :num_external_links_to_page => {
      :name => "All external links page to page",
      :flag => 2**39,
      :key => :ued,
      :desc => %Q[The number of external links from one page to another (included followed and nofollowed).]
    },
    :num_follow_subdomains_to_page => {
      :name => "Followed Subdomains Linking Page",
      :key => :ujfq,
      :flag => 2**40,
      :desc => %Q[The number of unique subdomains with followed links to the target url.]
    },
    :num_follow_ips_link => {
      :name => "Followed IPs Linking",
      :key => :ujp,
      :flag => 2**41,
      :desc => %Q[The number unique IPs with a followable link to a target url.]
    },
    :num_ips_link => {
      :name => "IPs Linking",
      :key => :uip,
      :flag => 2**42,
      :desc => %Q[The total number of  unique IPs linking to a target url.]
    },
    :num_follow_domains_to_page => {
      :name => "Number of Followed Domains Linking to Page",
      :key => :ujpl,
      :flag => 2**43,
      :desc => %Q[The number of unique domains with followed links to a given url.]
    },
    :num_cblocks_to_page => {
      :name => "Number of C blocks with links to Page",
      :key => :uib,
      :flag => 2**44,
      :desc => %Q[The total number unique cblocks linking to a page.]
    },
    :num_follow_cblocks_link => {
      :name => "Followed CBlocks Linking",
      :key => :ujb,
      :flag => 2**45,
      :desc => %Q[The total number unique cblocks with followed links to a page.]
    },
    :num_follow_links_to_subdomain => {
      :name => "Number of Followed Links to Subdomain",
      :key => :fjid,
      :flag => 2**46,
      :desc => %Q[A count of all unique subdomains with followed links to the target domain.]
    },
    :num_external_links_to_subdomain => {
      :name => "Number of External Links to Subdomain",
      :flag => 2**47,
      :key => :fed,
      :desc => %Q[The total number (followed and nofollowed) external links to the subdomain of the url.]
    },
    :num_follow_subdomain_to_subdomain => {
      :name => "Followed Subdomain Subdomains Links",
      :flag => 2**48,
      :key => :fjf,
      :desc => %Q[The number of subdomains with followed links to the subdomain of the url.]
    },
    :num_follow_domains_to_subdomain => {
      :name => "Number of Domains with Follow Links to Subdomain",
      :key => :fjd,
      :flag => 2**49,
      :desc => %Q[The number of unique domains with followed links to the subdomain of the url.]
    },
    :num_follow_links_to_domain => {
      :name => "Number of Followed Links to Domain",
      :flag => 2**50,
      :key => :pjid,
      :desc => %Q[The total number of followed links (both internal and external) from a page to a domain.]
    },
    :num_external_links_to_domain => {
      :name => "Numer of External Links to Domain",
      :flag => 2**51,
      :key => :ped,
      :desc => %Q[The total number of external links (both followed and no-followed) from a page to a domain.]
    },
    :num_follow_domains_to_domain => {
      :name => "Number of Domains with Follow Links to Domain",
      :flag => 2**52,
      :key  => :pjd,
      :desc => %Q[The total number of followed root domains linking to the target's domain.]
    },
    :num_ips_link_to_domain => {
      :name => "IPs Linking to Domain",
      :flag => 2**53,
      :key => :pip,
      :desc => %Q[The total number of unique IPs linking to the target's domain.]
    },
    :num_followed_ips_link_to_domain => {
      :name => "Followed IPs Linking to Domain",
      :flag => 2**54,
      :key => :pjip,
      :desc => %Q[The total number of  unique IPs with followed links to the target's domain.]
    },
    :num_cblocks_to_domain => {
      :name => "Number of C Blocks with Link to Domain",
      :flag => 2**55,
      :key  => :pib,
      :desc => %Q[The number of unique cblocks with a link to a domain.]
    },
    :num_follow_cblocks_link_domain => {
      :nam => "Followed Cblock Linking Domain",
      :flag => 2**56,
      :key => :pjb,
      :desc => %Q[The total number of cblock with followed links to a domain.]
    },
    :num_nofollow_links_to_page => {
      :name => 'Number of non Juice Passing Links Linking',
      :flag => 2**58,
      :key => :unid,
      :desc => %Q[The number of non-juice-passing links (internal or external) to the url.]
    },
    :num_nofollow_links_to_subdomain => {
      :name => 'Number of nofollow Links to Subdomain',
      :flag => 2**59,
      :key => :fnid,
      :desc => %Q[The number of non-juice-passing links to the subdomain of the url.]
    },
    :num_nofollow_links_to_domain => {
      :name => 'Number of non Juice Links Linking to Root Domain',
      :flag => 2**60,
      :key => :pnid,
      :desc => %Q[The number of non-juice-passing links to the root domain of the url.]
    },

    # Fields that should not be included as flags, but are included in responses.
    :internal_source_url_id => {
      :name => 'Internal Source URL ID',
      :key  => :lsrc,
      :desc => %Q[Internal ID of the source URL (Link)]
    },
    :internal_target_url_id => {
      :name => 'Internal Target URL ID',
      :key  => :ltgt,
      :desc => %Q[Internal ID of the target URL (Link)]
    },
    :canonical_internal_id => {
      :name => "Internal ID of Canonical",
      :key => :urrid,
      :desc => %Q[Internal ID of the canonical URL (Source)]
    },

    :internal_link_id => {
      :name => "Internal Link ID",
      :key => :lrid,
      :desc => %Q[Internal ID of the link (Link)]
    },
    :target_root_domain => {
      :name => "Target Root Domain",
      :key => :luupl,
      :desc => %Q[The pay-level domain (PL domain) as it's identified in the Linkscape index (Target)]
    },
    :target_subdomain => {
      :name => "Target Subdomain",
      :key => :luufq,
      :desc => %Q[The fully qualified domain (subdomain) as it's identified in the Linkscape index (Target)]
    },
    :anchor_is_image => {
      :name => "Is the Anchor an Image?",
      :flag => 2**10,
      :key => :atuf,
      :desc => %Q[If the anchor is an image]
    }
  }

  MACHINE = {
    :atfiu => {
      :human => :num_internal_page_links_with_anchor
    },
    :atfef => {
      :human => :anchors_num_external_subdomains_linking
    },
    :atfif => {
      :human => :num_subdomains_on_domain_with_anchor_text
    },
    :atfimp => {
      :human => :anchors_internal_mozrank_passed
    },
    :atfemp => {
      :human => :anchors_external_mozrank_passed
    },
    :atfeu => {
      :human => :num_external_page_links_with_anchor
    },
    :atfep => {
      :human => :num_external_root_domain_links_with_anchor
    },
    :atft => {
      :human => :anchors_anchor_text
    },
    :atpef => {
      :human => :anchors_num_external_subdomains_linking
    },
    :atpif => {
      :human => :num_subdomains_on_domain_with_anchor_text
    },
    :atpimp => {
      :human => :anchors_internal_mozrank_passed
    },
    :atpemp => {
      :human => :anchors_external_mozrank_passed
    },
    :atpiu => {
      :human => :num_internal_page_links_with_anchor
    },
    :atpt => {
      :human => :anchors_anchor_text
    },
    :atpeu => {
      :human => :num_external_page_links_with_anchor
    },
    :atpep => {
      :human => :num_external_root_domain_links_with_anchor
    },
    :appef => {
      :human => :anchors_num_external_subdomains_linking
    },
    :appiu => {
      :human => :num_internal_page_links_with_anchor
    },
    :appimp => {
      :human => :anchors_internal_mozrank_passed
    },
    :appemp => {
      :human => :anchors_external_mozrank_passed
    },
    :appt => {
      :human => :anchors_anchor_text
    },
    :appeu => {
      :human => :num_external_page_links_with_anchor
    },
    :appep => {
      :human => :num_external_root_domain_links_with_anchor
    },
    :appif => {
      :human => :num_subdomains_on_domain_with_anchor_text
    },
    :apfef => {
      :human => :anchors_num_external_subdomains_linking
    },
    :apfif => {
      :human => :num_subdomains_on_domain_with_anchor_text
    },
    :apfiu => {
      :human => :num_internal_page_links_with_anchor
    },
    :apfimp => {
      :human => :anchors_internal_mozrank_passed
    },
    :apfemp => {
      :human => :anchors_external_mozrank_passed
    },
    :apft => {
      :human => :anchors_anchor_text
    },
    :apfeu => {
      :human => :num_external_page_links_with_anchor
    },
    :apfep => {
      :human => :num_external_root_domain_links_with_anchor
    },
    :apuef => {
      :human => :anchors_num_external_subdomains_linking
    },
    :apuif => {
      :human => :num_subdomains_on_domain_with_anchor_text
    },
    :apuiu => {
      :human => :num_internal_page_links_with_anchor
    },
    :apuimp => {
      :human => :anchors_internal_mozrank_passed
    },
    :apuemp => {
      :human => :anchors_external_mozrank_passed
    },
    :aput => {
      :human => :anchors_anchor_text
    },
    :apueu => {
      :human => :num_external_page_links_with_anchor
    },
    :apuep => {
      :human => :num_external_root_domain_links_with_anchor
    },
    :atuif => {
      :human => :num_subdomains_on_domain_with_anchor_text
    },
    :urid => {
      :human => :internal_id,
      :desc => %Q[Internal ID of the URL (Source)]
    },
    :aturid => {
      :human => :internal_id,
      :desc => %Q[Internal ID for the anchor term]
    },
    :apurid => {
      :human => :internal_id,
      :desc => %Q[Internal ID for anchor phrase]
    },
    :apfrid => {
      :human => :internal_id,
      :desc  => %Q[Internal ID for anchor phrases to subdomain]
    },
    :apprid => {
      :human => :internal_id,
      :desc  => %Q[Internal ID for anchor phrases to domain]
    },
    :atprid => {
      :human => :internal_id,
      :desc  => %Q[Internal ID for anchor terms to domain]
    },
    :atfrid => {
      :human => :internal_id,
      :desc  => %Q[Internal ID for anchor terms to subdomain]
    },
    :apuf => {
      :human => :anchor_is_image,
      :desc  => %Q[The anchor is an image]
    },
    :appf => {
      :human => :anchor_is_image,
      :desc  => %Q[The anchor is an image]
    },
    :apff => {
      :human => :anchor_is_image,
      :desc => %Q[The anchor is an image]
    },
    :atpf => {
      :human => :anchor_is_image,
      :desc  => %Q[The anchor is an image]
    },
    :atff => {
      :human => :anchor_is_image,
      :desc  => %Q[The anchor is an image]
    },
    :urls => {
      :human => :num_urls_crawled
    },
    :fqdns => {
      :human => :num_domains_crawled
    },
    :plds => {
      :human => :num_root_domains_crawled
    },
    :links => {
      :human => :num_links_crawled
    },
    :nofollow => {
      :human => :links_crawled_nofollow_portion
    },
    :rel_canonical => {
      :human => :links_crawled_rel_canonical_portion
    },
    :links_per_page => {
      :human => :average_num_links_per_page_crawled
    },
    :external_links_per_page => {
      :human => :average_num_external_links_per_page_crawled
    }
  }
  HUMAN.each { |key, value|
    value[:human] = key
    MACHINE[value[:key]] = value
  }
end
