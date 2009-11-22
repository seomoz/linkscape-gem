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
    if Array === data
      data.each_index do |i|
        puts %Q[[#{i}]]
        data[i].sort{|l,r|l.to_s<=>r.to_s}.each do |k,v|
          field = Linkscape::Constants::ResponseFields[k]
          desc = field ? field[:desc] : k.inspect
          puts %Q[     #{desc}: \t#{v}]
        end
        puts ''
      end
    elsif Hash === data
      data.sort{|l,r|l.to_s<=>r.to_s}.each do |k,v|
        field = Linkscape::Constants::ResponseFields[k]
        desc = field ? field[:desc] : k.inspect
        puts %Q[#{desc}: \t#{v}]
      end
    end
  else
    puts "Response invalid"
  end
  puts "\n\n"
end

# do_request c.mozRank('http://www.martian.at/')

# do_request c.urlMetrics('http://www.martian.at/', :cols => [:all])

do_request c.topLinks('http://www.martian.at/', :page, :urlcols => [:title, :url, :links, :mozrank, :moztrust], :linkcols => [:anchor_text])

# do_request c.allLinks('http://www.martian.at/', :page, :domain, :domains_linking_page, :urlcols => :all, :linkcols => :all, :filters => :external)

# do_request c.topPages('http://www.martian.at/', :page, :cols => [:title, :url, :mozrank, :moztrust, :all], :limit => 3)

# do_request c.anchorMetrics('http://www.martian.at/', :cols => [:all], :scope => "page_to_domain", :filters => :external)
