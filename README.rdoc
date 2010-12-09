= Linkscape Gem

This is the official Gem to interact with the SEOmoz API.  For more information, please check out the {API page on SEOmoz}[http://www.seomoz.org/api] and the {SEOmoz API Wiki}[http://apiwiki.seomoz.org].   Note: this gem is currently an alpha release, and is not intended for production use...yet.

== Usage

First you must secure an accessID and secret key from SEOmoz.  See the {API page}[http://www.seomoz.org/api] for details.  Once you have your credentials, create an instance of your client:

  client = Linkscape::Client.new(:accessID => "my_access_id", :secret => "$secretp@$$w0rd")
  
Then you should be able to make one of the predefined API calls

  response = client.urlMetrics("http://gemcutter.org", :cols => :all)
  
At this point <tt>response</tt> should be a Linkscape::Response object.  You can get at its data by calling

  response.data
  
This returns a Linkscape::Response::ResponseData object, which is the container class for the response data.

For the urlMetrics and mozrank call, you can request specific data points, like:

  response.data[:url]
  response.data[:external_links]
  response.data[:page_authority]
  
For all other calls, such as anchor text, top pages and link data sets, <tt>data</tt> is an array of ResponseData objects, with each one keyed on their respective types.  For example:

 response.data.first[:source][:mozrank]               # :source just for topPages and link calls
 response.data.first[:target][:page_authority]        # :target just for link calls
 response.data.first[:link][:text]                    # :link just for link calls
 response.data.first[:anchor][:text]                  # :anchor just for link anchorMetrics calls

== Available API Calls

The Linkscape::Client object can make the following API calls:

=== mozRank

Returns the mozRank of the supplied URI.

  client.mozRank(uri)

=== urlMetrics

Returns metrics about the supplied URI.

  client.urlMetrics(uri, :cols => :all)

This call accepts the following options:

* <tt>:cols</tt> - An array of columns (see below) to return in the response, or the <tt>:all</tt> keyword, which returns all columns.

=== topLinks

Returns a list of topLinks to the supplied URI and :type.

  client.topLinks(uri, :page, :urlcols => :all, :linkcols => :all, :limit => 3))

The 2nd parameter of this method, <tt>:type</tt> can be either <tt>:page</tt>, <tt>:subdomain</tt> <tt>:domain</tt>.  It specifies the type of links you are requesting (links to the supplied URI, Root Domain or the Subdomain of the supplied URI).

This call accepts the following options:

* <tt>:sourcecols</tt> - An array of data columns (see below) that should be returned for the link source.
* <tt>:targetcols</tt> - An array of data columns (see below) that should be returned for the link target.
* <tt>:linkcols</tt> - An array of data columns (see below) that should be returned for the link itself.
* <tt>:limit</tt> - The # of links (limit) you would like to return.
* <tt>:offset</tt> = The number of records to offset before returning the 1st record of results.

=== allLinks

Returns all the links to a specific URI and :type.

  client.allLinks(uri, :page, :urlcols => [:title, :url, :page_authority, :domain_authority], :linkcols => :all, :filters => :external, :limit => 3)

The 2nd parameter of this method, <tt>:type</tt> can be either <tt>:page</tt>, <tt>:subdomain</tt> <tt>:domain</tt>.  It specifies the type of links you are requesting (links to the supplied URI, Root Domain or the Subdomain of the supplied URI).

This call accepts the following options:

* <tt>:sourcecols</tt> - An array of data columns (see below) that should be returned for the link source.
* <tt>:targetcols</tt> - An array of data columns (see below) that should be returned for the link target.
* <tt>:linkcols</tt> - An array of data columns (see below) that should be returned for the link itself.
* <tt>:filters</tt> - A String, Array or Symbol of filters (see below) that should be applied to the list of links.  NOTE: Multiple filters may be combined, i.e. <tt>:filters => [:internal,:follow,:redir301]</tt>.
* <tt>:limit</tt> - The # of links (limit) you would like to return.
* <tt>:offset</tt> = The number of records to offset before returning the 1st record of results.
* <tt>:scope</tt> - A symbol representing the 'scope' of the links (see below).

=== topPages

Returns a list of the top pages on the URI in question

  client.topPages(uri, :page, :cols => :all, :limit => 3)

The 2nd parameter of this method, <tt>:type</tt> can be either <tt>:page</tt>, <tt>:subdomain</tt> <tt>:domain</tt>.  It specifies the type of top pages you are requesting (top pages on the supplied URI, Root Domain or the Subdomain of the supplied URI).

This call accepts the following options:

* <tt>:cols</tt> - An array of data columns (see below) that should be returned for the link source.
* <tt>:limit</tt> - The # of links (limit) you would like to return.
* <tt>:offset</tt> = The number of records to offset before returning the 1st record of results.

=== anchorMetrics

Returns anchor text metrics about the URI in question

  client.anchorMetrics(uri, :cols => :all, :scope => "page_to_domain", :filters => :external, :sort => :domains_linking_page, :limit => 3, :scope => :phrase_to_page)

This call accepts the following options: 

* <tt>:cols</tt> - An array of data columns (see below) that should be returned.
* <tt>:scope</tt> - A symbol representing the 'scope' of the anchor text data (see below).
* <tt>:sort</tt> - A symbol representing the 'sort order' of the anchor text data (see below).
* <tt>:filters</tt> - A symbol representing the 'filter' of the anchor text data (see below).  NOTE: Only <tt>:external</tt> or <tt>internal</tt> filters may be used, separately.
* <tt>:limit</tt> - The # of links (limit) you would like to return.
* <tt>:offset</tt> = The number of records to offset before returning the 1st record of results.

== Requesting Data on Multiple URLs

For the API calls which support it, you may request data on multiple URLs by passing an
array of URLs to the API call.

  urls = ["http://www.seomoz.org/blog/21-tactics-to-increase-blog-traffic", "http://www.seomoz.org/tools"]
  response = client.urlMetrics(urls, :cols => :all)
  response.data.first[:url]
  >> "http://www.seomoz.org/blog/21-tactics-to-increase-blog-traffic"
  response.data.first[:external_links]
  >> 436

== Available Response Columns

Depending on the type of data point return, you may access certain data points inside the ResponseData object.

=== Source/Target/URL Metrics

* <tt>:all_external_links</tt>
* <tt>:canonical_internal_id</tt>
* <tt>:canonical_url</tt>
* <tt>:cblocks_linking</tt>
* <tt>:domain_authority</tt>
* <tt>:domain_authority_raw</tt>
* <tt>:external_links</tt>
* <tt>:external_mozrank</tt>
* <tt>:external_mozrank_raw</tt>
* <tt>:fq_domain</tt>
* <tt>:fq_domain_all_external_links</tt>
* <tt>:fq_domain_external_links</tt>
* <tt>:fq_domain_external_mozrank_sum</tt>
* <tt>:fq_domain_external_mozrank_sum_raw</tt>
* <tt>:fq_domain_fq_domains_linking</tt>
* <tt>:fq_domain_internal_links</tt>
* <tt>:fq_domain_juice_fq_domains_linking</tt>
* <tt>:fq_domain_juice_internal_links</tt>
* <tt>:fq_domain_juice_links</tt>
* <tt>:fq_domain_juice_pl_domains_linking</tt>
* <tt>:fq_domain_links</tt>
* <tt>:fq_domain_mozrank</tt>
* <tt>:fq_domain_mozrank_raw</tt>
* <tt>:fq_domain_mozrank_sum</tt>
* <tt>:fq_domain_mozrank_sum_raw</tt>
* <tt>:fq_domain_moztrust</tt>
* <tt>:fq_domain_moztrust_raw</tt>
* <tt>:fq_domain_pl_domains_linking</tt>
* <tt>:fq_domain_unfollowed_external_links</tt>
* <tt>:fq_domain_unfollowed_fq_domains_linking</tt>
* <tt>:fq_domain_unfollowed_internal_links</tt>
* <tt>:fq_domain_unfollowed_links</tt>
* <tt>:fq_domain_unfollowed_pl_domains_linking</tt>
* <tt>:fq_domain_updated_at</tt>
* <tt>:fq_domains_linking</tt>
* <tt>:internal_id</tt>
* <tt>:internal_links</tt>
* <tt>:ips_linking</tt>
* <tt>:juice_cblocks_linking</tt>
* <tt>:juice_fq_domains_linking</tt>
* <tt>:juice_internal_links</tt>
* <tt>:juice_ips_linking</tt>
* <tt>:juice_links</tt>
* <tt>:juice_pl_domains_linking</tt>
* <tt>:links</tt>
* <tt>:mozrank</tt>
* <tt>:mozrank_raw</tt>
* <tt>:moztrust</tt>
* <tt>:moztrust_raw</tt>
* <tt>:page_authority</tt>
* <tt>:page_authority_raw</tt>
* <tt>:pl_domain</tt>
* <tt>:pl_domain_all_external_links</tt>
* <tt>:pl_domain_cblocks_linking</tt>
* <tt>:pl_domain_external_links</tt>
* <tt>:pl_domain_external_mozrank_sum</tt>
* <tt>:pl_domain_external_mozrank_sum_raw</tt>
* <tt>:pl_domain_internal_links</tt>
* <tt>:pl_domain_ips_linking</tt>
* <tt>:pl_domain_juice_cblocks_linking</tt>
* <tt>:pl_domain_juice_internal_links</tt>
* <tt>:pl_domain_juice_ips_linking</tt>
* <tt>:pl_domain_juice_links</tt>
* <tt>:pl_domain_juice_pl_domains_linking</tt>
* <tt>:pl_domain_links</tt>
* <tt>:pl_domain_mozrank</tt>
* <tt>:pl_domain_mozrank_raw</tt>
* <tt>:pl_domain_mozrank_sum</tt>
* <tt>:pl_domain_mozrank_sum_raw</tt>
* <tt>:pl_domain_moztrust</tt>
* <tt>:pl_domain_moztrust_raw</tt>
* <tt>:pl_domain_pl_domains_linking</tt>
* <tt>:pl_domain_unfollowed_cblocks_linking</tt>
* <tt>:pl_domain_unfollowed_external_links</tt>
* <tt>:pl_domain_unfollowed_internal_links</tt>
* <tt>:pl_domain_unfollowed_ips_linking</tt>
* <tt>:pl_domain_unfollowed_links</tt>
* <tt>:pl_domain_unfollowed_pl_domains_linking</tt>
* <tt>:pl_domain_updated_at</tt>
* <tt>:pl_domains_linking</tt>
* <tt>:status</tt>
* <tt>:title</tt>
* <tt>:unfollowed_cblocks_linking</tt>
* <tt>:unfollowed_external_links</tt>
* <tt>:unfollowed_fq_domains_linking</tt>
* <tt>:unfollowed_internal_links</tt>
* <tt>:unfollowed_ips_linking</tt>
* <tt>:unfollowed_links</tt>
* <tt>:unfollowed_pl_domains_linking</tt>
* <tt>:updated_at</tt>
* <tt>:url</tt>


=== Link Metrics

* <tt>:text</tt>
* <tt>:mozrank</tt> (passed)

=== Anchor Text Metrics

* <tt>:flags</tt>
* <tt>:internal_mozrank</tt>
* <tt>:internal_pages_linking</tt>
* <tt>:external_subdomains_linking</tt>
* <tt>:external_mozrank</tt>
* <tt>:text</tt>
* <tt>:internal_subdomains_linking</tt>
* <tt>:external_domains_linking</tt>
* <tt>:record_id</tt>
* <tt>:external_pages_linking</tt>

== Available Filters

Links may be filtered by any of the following.  Anchor text may o

* <tt>:internal</tt>
* <tt>:external</tt>
* <tt>:redir301</tt>
* <tt>:follow</tt>
* <tt>:nofollow</tt>

== Anchor Text Scope

When requesting anchor text data, the following scopes may be used.

* <tt>:phrase_to_page</tt>
* <tt>:phrase_to_subdomain</tt>
* <tt>:phrase_to_domain</tt>
* <tt>:term_to_page</tt>
* <tt>:term_to_subdomain</tt>
* <tt>:term_to_domain</tt>

== Link Scope

When requesting links, the following scope may be used

* <tt>:page_to_page</tt>
* <tt>:page_to_subdomain</tt>
* <tt>:page_to_domain</tt>
* <tt>:domain_to_page</tt>
* <tt>:domain_to_subdomain</tt>
* <tt>:domain_to_domain</tt>

== Sort Orders

When sorting links, the following sort orders are available.

* <tt>:page_athority</tt>
* <tt>:domain_authority</tt>
* <tt>:domains_linking_page</tt>
* <tt>:domains_linking_domain</tt>