require "spec_helper"

describe Linkscape::Metadata do
  before :all do
    FakeWeb.allow_net_connect = false
  end
  
  before :each do
    FakeWeb.clean_registry
    @uri = "http://lsapi.seomoz.com/linkscape/metadata/%s.json" 
  end

  context "finding next update" do
    it "should find the timestamp for next index update" do
      FakeWeb.register_uri(:get, @uri % 'next_update', :body => { next_update: 123456 }.to_json)
      Linkscape::Metadata.next_update.should eql(123456)
    end
  end
    
  context "finding last update" do
    it "should find the timestamp for last index update" do
      FakeWeb.register_uri(:get, @uri % 'last_update', :body => { last_update: 123456 }.to_json)
      Linkscape::Metadata.last_update.should eql(123456)
    end
  end
end
