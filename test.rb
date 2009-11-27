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
          desc = field ? field[:name] : k.inspect
          puts %Q[     #{desc}: \t#{v}]
        end
        puts ''
      end
    elsif Hash === data
      data.sort{|l,r|l.to_s<=>r.to_s}.each do |k,v|
        field = Linkscape::Constants::ResponseFields[k]
        desc = field ? field[:name] : k.inspect
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

# do_request c.topLinks('http://www.martian.at/', :page, :urlcols => [:title, :url, :links, :mozrank, :moztrust], :linkcols => [:anchor_text])

# do_request c.allLinks('http://www.martian.at/', :page, :domain, :domains_linking_page, :urlcols => :all, :linkcols => :all, :filters => :external)

# do_request c.topPages('http://www.martian.at/', :page, :cols => [:title, :url, :mozrank, :moztrust, :all], :limit => 3)

# do_request c.anchorMetrics('http://www.martian.at/', :cols => [:all], :scope => "page_to_domain", :filters => :external)




data={
  :feid=>481605,
  :fejp=>7.4055735182134,
  :fejr=>6.68613681782908e-07,
  :fid=>14255,
  :fjp=>8.09588689485189,
  :fjr=>3.79344515679382e-06,
  :fmrp=>6.89300374689526,
  :fmrr=>3.10819049689775e-06,
  :ftrp=>6.91834017226222,
  :ftrr=>7.86245113134823e-06,
  :lrid=>414782223349,
  :lsrc=>36591831679,
  :lt=>"",
  :ltgt=>36591759663,
  :lufeid=>481605,
  :lufejp=>7.4055735182134,
  :lufejr=>6.68613681782908e-07,
  :lufid=>14255,
  :lufjp=>8.09588689485189,
  :lufjr=>3.79344515679382e-06,
  :lufmrp=>6.89300374689526,
  :lufmrr=>3.10819049689775e-06,
  :luftrp=>6.91834017226222,
  :luftrr=>7.86245113134823e-06,
  :lupeid=>486405,
  :lupejp=>7.40735896872179,
  :lupejr=>6.71622234376799e-07,
  :lupid=>12409,
  :lupjp=>8.09633994717186,
  :lupjr=>3.79776918815381e-06,
  :lupmrp=>6.74165270308294,
  :lupmrr=>1.00602049685479e-05,
  :luptrp=>6.75155371059249,
  :luptrr=>1.22296171045621e-05,
  :luueid=>264,
  :luuemrp=>3.70885956746422,
  :luuemrr=>6.14000893451033e-11,
  :luufq=>"www.seomoz.org/",
  :luuid=>444,
  :luuifq=>157,
  :luuipl=>148,
  :luujid=>424,
  :luumrp=>4.11481118396432,
  :luumrr=>1.70407827824903e-10,
  :luupl=>"seomoz.org/",
  :luurid=>36591759663,
  :luurrid=>36591759663,
  :luus=>200,
  :luut=>"SEOmoz | 21 Tactics to Increase Blog Traffic",
  :luutrp=>4.71768245559764,
  :luutrr=>1.43179627656236e-11,
  :luuu=>"www.seomoz.org/blog/21-tactics-to-increase-blog-traffic",
  :peid=>486405,
  :pejp=>7.40735896872179,
  :pejr=>6.71622234376799e-07,
  :pid=>12409,
  :pjp=>8.09633994717186,
  :pjr=>3.79776918815381e-06,
  :pmrp=>6.74165270308294,
  :pmrr=>1.00602049685479e-05,
  :ptrp=>6.75155371059249,
  :ptrr=>1.22296171045621e-05,
  :ueid=>223,
  :uemrp=>3.66672165997436,
  :uemrr=>5.52270937496186e-11,
  :ufq=>"www.seomoz.org/",
  :uid=>275,
  :uifq=>144,
  :uipl=>137,
  :ujid=>227,
  :umrp=>3.76585000129767,
  :umrr=>7.08607194199993e-11,
  :upl=>"seomoz.org/",
  :urid=>36591831679,
  :urrid=>36591759663,
  :us=>301,
  :ut=>"",
  :utrp=>4.41871660770819,
  :utrr=>4.14409514565574e-12,
  :uu=>"www.seomoz.org/rewritten/blogdetail.php?ID=1347"
}
puts data.inspect

data = Linkscape::Response::ResponseData.new(data)
puts data.inspect
# Linkscape::Constants::ResponseFields.each do |k,field|
#   v = data[k]
#   puts %Q[  #{k.inspect} - #{v}]
# end
data.subjects.each do |s|
  puts data[s].inspect
  data[s].each do |k,v|
    field = Linkscape::Constants::ResponseFields[k]
    desc = field ? field[:name] : k.inspect
    puts %Q[  #{s}.#{desc} - \t#{v}]
  end
end
