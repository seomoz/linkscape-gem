require "spec_helper"

describe Linkscape::Anchor do
  
  before :all do
    FakeWeb.allow_net_connect = false
  end
  
  before :each do
    FakeWeb.clean_registry
  end
  
  context "finding anchors" do
    it "is able to find anchors" do
      site = "test.com"
      uri = "http://lsapi.seomoz.com/linkscape/anchor-text/#{site}?Cols=1203&Limit=50&Offset=0&Scope=term_to_page&Sort=domains_linking_page"
      FakeWeb.register_uri(:get, uri, :body => '[{"test": "something"}]')
      Linkscape::Anchor.find(:all, :params => {:site => site, :Offset => 0, :Limit => 50}).length.should == 1
    end
  end
end
