require 'lib/linkscape'
require 'yaml'

config = YAML.load_file('seomoz.yml')

c = Linkscape::Client.new(:id => config["accessID"], :secret => config['secretKey'])
puts c.inspect

r = c.mozRank('http://www.martian.at/')
puts r.inspect
