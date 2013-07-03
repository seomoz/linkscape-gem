module Linkscape
  module Constants
    module LinkMetrics

      RequestBits = {
        :flags => {
          :name => 'Flags',
          :flag => 2**1, # 2
          :desc => %Q[A bit field indicating a variety of attributes which apply to this link.]
        },
        :text => {
          :name => 'Anchor Text',
          :flag => 2**2, # 4
          :desc => %Q[The anchor text of the link, including any markup (e.g. image tags with alt text).]
        },
        :normalized_text => {
          :name => 'Normalized Anchor Text',
          :flag => 2**3, # 8
          :desc => %Q[The anchor text of the link, excluding markup (e.g. image tags with alt text).]
        },
        :mozrank => {
          :name => 'mozRank Passed',
          :flag => 2**4, # 16
          :desc => %Q[The amount of mozRank passed by the link.  Requesting this metric will provide both the pretty 10-point score and the raw score.]
        }
      }
      RequestBits[:all] = {
        :name => 'All columns',
        :flag => RequestBits.keys.inject(0) {|sum,k| sum | RequestBits[k][:flag]},
        :desc => %Q[Requests all known columns from the API]
      }

      ResponseFlags = {
        :no_follow => {
          :name => 'No Follow',
          :flag => 2**0, # 1
          :desc => %Q[The link in question bore a "rel=nofollow" directive indicating that no juice should flow over the link.]
        },
        :same_subdomain => {
          :name => 'Same Subdomain',
          :flag => 2**1, # 2
          :desc => %Q[The link is between two pages on the same domain.  This is an internal link.]
        },
        :meta_refresh => {
          :name => 'Meta Refresh',
          :flag => 2**2, # 4
          :desc => %Q[The link is actually a meta refresh from the source page to the target.]
        },
        :same_ip_address => {
          :name => 'Same IP Address',
          :flag => 2**3, # 8
          :desc => %Q[The link is between two pages hosted on the same IP address, strongly indicating a potential administrative relationship between the two.]
        },
        :same_c_block => {
          :name => 'Same C-Block',
          :flag => 2**4, # 16
          :desc => %Q[The link is between two pages hosted on the same C Block of IP addresses, indicating a potential administrative relationship between the two.]
        },
        :redirect301 => {
          :name => '301',
          :flag => 2**6, # 64
          :desc => %Q[The link is a 301 redirect.  The source page returned a 301 redirect to our crawler, indicating that the resource was available on the target.]
        },
        :redirect302 => {
          :name => '302',
          :flag => 2**7, # 128
          :desc => %Q[The link is a 302 redirect.  The source page returned a 302 redirect to our crawler, indicating that the resource was temporarily available on the target.]
        },
        :no_script => {
          :name => 'No Script',
          :flag => 2**8, # 256
          :desc => %Q[The link was located within a noscript html block.  This means the link may not have been visible to users using javascript.]
        },
        :off_screen => {
          :name => 'Off Screen',
          :flag => 2**9, # 512
          :desc => %Q[We determined that the link likely appears offscreen.  This means that the link may not have been visible to most users.]
        },
        :meta_no_follow => {
          :name => 'Meta No Follow',
          :flag => 2**11, # 2048
          :desc => %Q[The link appeared on a page using a page level (meta) no follow directive.  This link passes no juice.]
        },
        :same_root_domain => {
          :name => 'Same Root Domain',
          :flag => 2**12, # 4096
          :desc => %Q[The link is between two pages on the same root domain.  The link is not internal, but this strongly indicates an administrative relationship between the two pages.]
        },
        :image_tag => {
          :name => 'Image Tag',
          :flag => 2**13, # 8192
          :desc => %Q[The link includes an img tag.]
        },
        :feed_autodiscovery => {
          :name => 'Feed Autodiscovery',
          :flag => 2**14, # 16384
          :desc => %Q[The link indicates a syndication feed (e.g. rss or atom) for the source page.]
        },
        :rel_canonical => {
          :name => 'Rel Canonical',
          :flag => 2**15, # 32768
          :desc => %Q[The link indicates a canonical form of the page using the rel=canonical directive]
        }
      }
      ResponseFlagMap = {}
      ResponseFlags.each {|k,v| ResponseFlagMap[v[:flag]] = k }

    end
  end
end
