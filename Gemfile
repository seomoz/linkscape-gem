source 'https://rubygems.org'
gemspec

gem 'rake', '>= 10'

%w[ rspec-core rspec-mocks rspec-expectations ].each do |name|
  gem name, '>= 2.12', git: "git://github.com/rspec/#{name}.git"
end

gem 'simplecov', :require => false, :group => :test
gem 'vcr', '>= 2.2'
gem 'debugger', '>= 0.10.4'
gem 'timecop', '>= 0.3.5'
