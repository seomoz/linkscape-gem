require 'spec_helper'

describe Linkscape::Link do
  
  before(:all) do
    FakeWeb.allow_net_connect = false
  end
  
  before(:each) do
    Linkscape::Resource.user = nil
    Linkscape::Resource.password = nil
    Linkscape::Resource.reset_crummy_cache
    FakeWeb.clean_registry
  end
  
  it "can set the values of fields with question marks" do
    link = Linkscape::Link.new(:http_301? => true)
    link.http_301?.should be_true
  end  
  
  context "calculating 'to page' links" do
    
    before(:each) do
      @criteria = {
        :target => "page"
      }
    end
    
    it "is able to calculate the number of followed links" do
      metrics = Linkscape::UrlMetric.new({:ujid => 100})
      @criteria[:filter] = "followed_301"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 100
    end
    
    it "is able to calculate the number of external followed links" do
      metrics = Linkscape::UrlMetric.new({:ueid => 100})
      @criteria[:filter] = "followed_301"
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 100
    end
    
    it "is able to calculate the number of internal followed links" do
      metrics = Linkscape::UrlMetric.new({:ueid => 5, :ujid => 10})
      @criteria[:filter] = "followed_301"
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 5
    end
    
    it "is able to calculate the number of nofollow links" do
      metrics = Linkscape::UrlMetric.new({:uid => 10, :ujid => 5})
      @criteria[:filter] = "nofollow"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 5
    end
    
    it "is able to calculate the number of external nofollow links" do
      metrics = Linkscape::UrlMetric.new({:ued => 10, :ueid => 5})
      @criteria[:filter] = "nofollow"
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 5
    end
    
    it "is able to calculate nofollow links" do
      metrics = Linkscape::UrlMetric.new({:ued => 10, :ueid => 5, :uid => 10, :ujid => 1})
      @criteria[:filter] = "nofollow"
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 4
    end
    
    it "is able to calculate internal links" do
      metrics = Linkscape::UrlMetric.new({:ujid => 10, :ueid => 5})
      @criteria[:filter] = "followed_301"
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 5
    end
    
    it "is able to calculate external links" do
      metrics = Linkscape::UrlMetric.new({:ued => 10})
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "is able to calculate the number of links" do
      metrics = Linkscape::UrlMetric.new({:uid => 10})
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "is able to get the count from cache" do
      Linkscape::Link.set_cached_max_offset({:site => "test.com/"}, 3)
      Linkscape::Link.theoretical_count("test.com/", {}, Linkscape::UrlMetric.new).should == 3
    end
  end
  
  context "calculating 'to subdomain' link counts" do
    before(:each) do
      @criteria = {
        :target => "subdomain"
      }
    end
    
    it "calculates number of followed links" do
      metrics = Linkscape::UrlMetric.new({:fjid => 10})
      @criteria[:filter] = "followed_301"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "calculates the number of external followed links" do
      metrics = Linkscape::UrlMetric.new({:feid => 7, :fjid => 10})
      @criteria[:filter] = "followed_301"
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 7
    end
    
    it "calculates the number of internal followed links" do
      metrics = Linkscape::UrlMetric.new({:feid => 7, :fjid => 10})
      @criteria[:filter] = "followed_301"
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 3
    end
    
    it "calculates the number of nofollow links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10, :fjid => 7})
      @criteria[:filter] = "nofollow"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 3
    end
    
    it "calculates the number of external nofolllow links" do
      metrics = Linkscape::UrlMetric.new({:feid => 3, :fed => 10})
      @criteria[:source] = "external"
      @criteria[:filter] = "nofollow"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 7
    end
    
    it "calculates the number of internal nofollow links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10, :fjid => 1, :fed => 10, :feid => 3})
      @criteria[:source] = "internal"
      @criteria[:filter] = "nofollow"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 2
    end
    
    it "calculates the number of links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10})
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "calculates the number of external links" do
      metrics = Linkscape::UrlMetric.new({:fed => 10})
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "calculates the number of internal links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10, :fed => 7})
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 3
    end
  end
  
  context "calculating 'to domain' link counts" do
    
    before(:each) do
      @criteria = {
        :target => "domain"
      }
    end
    
    it "calculates the number of links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10})
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "calculates the number of external links" do
      metrics = Linkscape::UrlMetric.new({:ped => 10})
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "calculates the number of intenral links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10, :ped => 7})
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 3
    end
    
    it "calculates the number of nofollow links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10, :pjid => 7})
      @criteria[:filter] = "nofollow"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 3
    end
    
    it "calculates the number of nofollow external links" do
      metrics = Linkscape::UrlMetric.new({:peid => 3, :ped => 10})
      @criteria[:filter] = "nofollow"
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 7
    end
    
    it "calculates the number of internal nofollow links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10, :pjid => 1, :ped => 10, :peid => 3})
      @criteria[:filter] = "nofollow"
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 2
    end
    
    it "calculates the number of followed links" do
      metrics = Linkscape::UrlMetric.new({:pjid => 10})
      @criteria[:filter] = "followed_301"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "calculates the number of external follow links" do
      metrics = Linkscape::UrlMetric.new({:peid => 10})
      @criteria[:filter] = "followed_301"
      @criteria[:source] = "external"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 10
    end
    
    it "calculates the number of internal follow links" do
      metrics = Linkscape::UrlMetric.new({:pjid => 10, :peid => 7})
      @criteria[:filter] = "followed_301"
      @criteria[:source] = "internal"
      Linkscape::Link.theoretical_count("", @criteria, metrics).should == 3
    end
  end
  
  it "includes default values in collection_path" do
    path = Linkscape::Link.collection_path({:site => "seomoz.org"})
    path.should == "/linkscape/links/seomoz.org?Filter=&LinkCols=6&Scope=page_to_page&Sort=domain_authority&SourceCols=103079224341&TargetCols=28"
  end
end

def mock_count(site, url_metric)
  uri = "http://lsapi.seomoz.com/linkscape/url-metrics/" << site
  FakeWeb.register_uri(:get, uri, :body => url_metric.to_json)
end