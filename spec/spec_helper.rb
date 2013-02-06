require 'simplecov'

SimpleCov.start do
  add_filter "/bundle"
end

SimpleCov.at_exit do
  File.open(File.join(SimpleCov.coverage_path, 'coverage_percent.txt'), 'w') do |f|
    f.write SimpleCov.result.covered_percent
  end
  SimpleCov.result.format!
end

require 'vcr'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.filter_run :f
  c.run_all_when_everything_filtered = true
  c.alias_example_to :fit, :f
  c.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    match_requests_on: [:method, :consistent_uri]
  }
  c.register_request_matcher(:consistent_uri, &VCR.request_matchers.uri_without_params(:timestamp, :signature))
end

shared_context "VCR recorded time", :vcr_recorded_time do
  let(:recorded_time) do
    dir = VCR.current_cassette.file.gsub(/\.[^\.]+/, '')
    file_name = dir + '/recorded_time'
    if File.exist?(file_name)
      Time.iso8601(File.read file_name)
    else
      Time.now.getutc.tap do |t|
        FileUtils.mkdir_p(dir)
        File.open(file_name, 'w') { |f| f.write(t.iso8601) }
      end
    end
  end
end
