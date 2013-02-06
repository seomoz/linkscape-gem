require 'spec_helper'
require 'timecop'
require 'linkscape/client'
require 'yaml'
require 'linkscape'

module Linkscape
  describe Client, :vcr, :vcr_recorded_time do

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
      client = Client.new(credentials.fetch('accessID'), credentials.fetch('secretKey'))
      data = client.index_name
      expect(data.index).to be > 0
      expect(data.sub_index).to be > 0
    end
  end
end
