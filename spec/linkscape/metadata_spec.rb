require "spec_helper"

describe Linkscape::Metadata do
  before :all do
    FakeWeb.allow_net_connect = false
  end
  
  before { FakeWeb.clean_registry }

  let(:uri) { 'http://lsapi.seomoz.com/linkscape/metadata/%s.json' }

  describe '::next_update' do
    it "should find the timestamp for next index update" do
      FakeWeb.register_uri(:get, uri % 'next_update', body: { next_update: 123456 }.to_json)
      described_class.next_update.should eql(123456)
    end
  end
    
  describe '::last_update' do
    it "should find the timestamp for last index update" do
      FakeWeb.register_uri(:get, uri % 'last_update', body: { last_update: 123456 }.to_json)
      described_class.last_update.should eql(123456)
    end
  end

  describe '::index_stats' do
    it 'returns the current set of index stats, humanized' do
      stats = { urls: 83122215182, fqdns: 12140091376, plds: 141967157, links: 801586268337 }
      FakeWeb.register_uri(:get, uri % 'index_stats', body: stats.to_json)
      result = described_class.index_stats
      result.num_urls_crawled.should == stats[:urls]
      result.num_domains_crawled.should == stats[:fqdns]
      result.num_root_domains_crawled.should == stats[:plds]
      result.num_links_crawled.should == stats[:links]
    end
  end
end
