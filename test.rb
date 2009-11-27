require 'lib/linkscape'
require 'yaml'

if File.exists? 'seomoz.yml'
  config = YAML.load_file('seomoz.yml')
elsif File.exists? ENV['HOME']+'/.seomoz.yml'
  config = YAML.load_file(ENV['HOME']+'/.seomoz.yml')
else
  print "Need a config file to read settings from"
  exit
end

c = Linkscape::Client.new(:id => config["accessID"], :secret => config['secretKey'])
puts c.inspect

def do_request r
  puts r.inspect
  puts ''
  if(r.valid?)
    data = r.data
    puts data.inspect
    if data.type == :array
      data.each_index do |i|
        puts %Q[[#{i}]]
        puts data[i].inspect
        puts data[i].to_s("   ")
        puts ''
      end
    else
      puts data.to_s("")
    end
  else
    puts "Response invalid"
  end
  puts "\n\n"
end

url = %q[http://www.seomoz.org/blog/21-tactics-to-increase-blog-traffic]

do_request c.mozRank(url)

do_request c.urlMetrics(url, :cols => :all)

do_request c.topLinks(url, :page, :urlcols => :all, :linkcols => :all, :limit => 3)

# do_request c.allLinks(url, :page, :domain, :domains_linking_page, :urlcols => :all, :linkcols => :all, :filters => :external)

do_request c.topPages(url, :page, :cols => :all, :limit => 3, :limit => 3)

# do_request c.anchorMetrics(url, :cols => :all, :scope => "page_to_domain", :filters => :external)
