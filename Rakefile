task :default => [:test, :check_coverage]

task :test do
  sh "bundle exec rspec spec/unit"
end

desc "Checks the spec coverage and fails if it is less than 100%"
task :check_coverage do
  puts "Checking code coverage..."
  percent = File.read("coverage/coverage_percent.txt").to_f
  puts " - #{percent}%"
end
