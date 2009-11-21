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

# r = c.mozRank('http://www.martian.at/')
# puts r.inspect
# puts ''
# r.data.each do |k,v|
#   puts %Q[#{Linkscape::Constants::ResponseFields[k][:desc]}:\n\t#{v}]
# end
# puts "\n\n"

r = c.urlMetrics('http://www.martian.at/', :cols => [:title, :canonical_url, :mozrank, :moztrust, :links, :all])
puts r.inspect
puts ''
r.data.sort{|l,r|l.to_s<=>r.to_s}.each do |k,v|
  field = Linkscape::Constants::ResponseFields[k]
  desc = field ? field[:desc] : k.inspect
  puts %Q[#{desc}:\n\t#{v}]
end

puts "\n\n"

r = c.urlMetrics('http://www.amazon.com/', :cols => [:title, :canonical_url, :mozrank, :moztrust, :links, :all])
puts r.inspect
puts ''
r.data.sort{|l,r|l.to_s<=>r.to_s}.each do |k,v|
  field = Linkscape::Constants::ResponseFields[k]
  desc = field ? field[:desc] : k.inspect
  puts %Q[#{desc}:\n\t#{v}]
end
