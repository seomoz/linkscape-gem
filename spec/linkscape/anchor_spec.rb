require "spec_helper"

describe Linkscape::Anchor do
  before :all do
    FakeWeb.allow_net_connect = false
  end

  before do
    FakeWeb.clean_registry
  end

  context "finding anchors" do
    it "is able to find anchors" do
      site = "test.com"
      uri = "http://lsapi.seomoz.com/linkscape/anchor-text/#{site}?Cols=2305843009213695163&Limit=50&Offset=0&Scope=term_to_page&Sort=domains_linking_page"
      FakeWeb.register_uri(:get, uri, :body => '[{"test": "something"}]')
      described_class.find(:all, :params => {:site => site, :Offset => 0, :Limit => 50}).length.should == 1
    end
  end

  describe '#num_page_links_with_anchor' do
    let(:options) do
      { num_internal_page_links_with_anchor: 1, num_external_page_links_with_anchor: 1 }
    end

    subject { described_class.new(options) }

    it 'is nil if num_internal_page_links_with_anchor is not present' do
      options.delete(:num_internal_page_links_with_anchor)
      subject.num_page_links_with_anchor.should be_nil
    end

    it 'is nil if num_external_page_links_with_anchor is not present' do
      options.delete(:num_external_page_links_with_anchor)
      subject.num_page_links_with_anchor.should be_nil
    end

    it 'adds the page links fields together' do
      subject.num_page_links_with_anchor.should == 2
    end
  end
end
