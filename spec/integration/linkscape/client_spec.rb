require 'spec_helper'
require 'timecop'
require 'linkscape/client'
require 'yaml'
require 'linkscape'

require 'pp'
require 'debugger'

module Linkscape
  describe Client, :vcr, :vcr_recorded_time do
    let(:client) { Client.new(credentials.fetch('accessID'), credentials.fetch('secretKey')) }
    let(:credentials) do
      YAML.load_file(Linkscape.root_directory + 'config/credentials.yml')
    end

    before(:each) do
      Timecop.freeze(recorded_time)
    end

    after(:each) do
      Timecop.return
    end

    it "gets the latest mozscape index" do
      data = client.index_name
      expect(data.index).to be > 0
      expect(data.sub_index).to be > 0
    end

    describe '#topPages' do
      let(:uri)      { 'moz.com' }
      let(:uri_type) { 'subdomain' }
      let(:sort)     { :page_authority }
      let(:schema_source_columns) do
        [
          :title,
          :url,
          :page_authority,
          :pl_domains_linking,
          :all_external_links,
          :status,
          :url_schema
        ]
      end

      it 'supports filtering by response code' do
        params = {
            :cols => schema_source_columns,
            :sort => sort,
            :limit => 4,
            :offset => 0,
            :filter => 'status4xx'
          }
        response = client.topPages(uri, uri_type, params)
        statuses = response.data.map { |d| d[:source][:status] }
        expect(statuses.size).to be > 0
        statuses.each { |s| expect(s).to be_between(400, 499) }
      end
    end
  end
end
