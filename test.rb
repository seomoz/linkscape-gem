require 'lib/linkscape'
require 'yaml'

if File.exists? 'seomoz.yml'
  config = YAML.load_file('seomoz.yml')
elsif File.exists? ENV['HOME']+'/.seomoz.yml'
  config = YAML.load_file(ENV['HOME']+'/.seomoz.yml')
else
  puts "Need a config file to read settings from"
  exit
end

c = Linkscape::Client.new(:id => config["accessID"], :secret => config['secretKey'])

def do_request r
  puts r.inspect
  puts ''
  puts r.response.body
  puts ''
  if(r.valid?)
    data = r.data
    puts data.inspect
    puts data.to_s("")
  else
    puts "Response invalid"
  end
  puts "\n\n"
end

url = %q[http://www.seomoz.org/blog/21-tactics-to-increase-blog-traffic]
url_array = ["http://www.seomoz.org/blog/21-tactics-to-increase-blog-traffic", "http://www.seomoz.org/tools"]

# do_request c.mozRank(url)

do_request c.urlMetrics(url_array, :cols => :all)

# do_request c.topLinks(url, :page, :urlcols => :all, :linkcols => :all, :limit => 3)
# # 
# do_request c.allLinks(url, :page, :domain, :domains_linking_page, :urlcols => [:title, :url, :page_authority, :domain_authority], :linkcols => :all, :filters => :external, :limit => 3)
# # 
# do_request c.topPages(url, :page, :cols => :all, :limit => 3, :limit => 3)
# # 
# do_request c.anchorMetrics(url, :phrase, :page, :cols => :all, :scope => "page_to_domain", :filters => :external, :sort => :domains_linking_page, :limit => 3)
