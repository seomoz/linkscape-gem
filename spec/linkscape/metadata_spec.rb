require "spec_helper"

describe Linkscape::Metadata do
  before :all do
    FakeWeb.allow_net_connect = false
  end
  
  before { FakeWeb.clean_registry }

  describe '::next_update' do
    it "should find the timestamp for next index update" do
      register_endpoint('next_update', { next_update: 123456 })
      described_class.next_update.should == 123456
    end
  end

  describe '::last_update' do
    it "should find the timestamp for last index update" do
      register_endpoint('last_update', { last_update: 234567 })
      described_class.last_update.should == 234567
    end
  end

  describe '::crawl_duration' do
    it 'finds the duration of the current crawl' do
      register_endpoint('crawl_duration', { crawl_duration: 38 })
      described_class.crawl_duration.should == 38
    end
  end

  describe '::index_stats' do
    it 'returns the current set of index stats, humanized' do
      stats = { urls: 83122215182, fqdns: 12140091376, plds: 141967157, links: 801586268337 }
      FakeWeb.register_uri(
        :get,
        'http://lsapi.seomoz.com/linkscape/metadata/index_stats',
        body: stats.to_json
      )
      register_endpoint('index_stats', stats)
      result = described_class.index_stats
      result.num_urls_crawled.should == stats[:urls]
      result.num_domains_crawled.should == stats[:fqdns]
      result.num_root_domains_crawled.should == stats[:plds]
      result.num_links_crawled.should == stats[:links]
    end
  end

  def register_endpoint(id, body)
    FakeWeb.register_uri(
      :get,
      "http://lsapi.seomoz.com/linkscape/metadata/#{id}.json",
      body: body.to_json
    )
  end
end
