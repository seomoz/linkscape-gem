require 'spec_helper'

describe Linkscape::Resource do
  
  before(:all) do
    FakeWeb.allow_net_connect = false
  end
  
  before(:each) do
    Linkscape.config.cache.clear
    Linkscape::Resource.user = nil
    Linkscape::Resource.password = nil
    Linkscape::Resource.reset_crummy_cache
    FakeWeb.clean_registry
  end
  
  after(:all) do
    FakeWeb.allow_net_connect = true
  end
  
  context "generating the correct collection path" do
    it "does not include a file extension" do
       Linkscape::Resource.collection_path({:site => "seomoz.org"}).should == "/linkscape/resources/seomoz.org"
     end

     it "encodes special characters" do
       Linkscape::Resource.collection_path({:site => "seomoz.org/blog"}).should == "/linkscape/resources/seomoz.org%2Fblog"
     end
   
     it "automatically uppercases sort" do
       path = Linkscape::Resource.collection_path({:site => "seomoz.org", :sort => :my_sort})
       path.should == "/linkscape/resources/seomoz.org?Sort=my_sort"
     end
   
     it "does not override an existing Sort property" do
       path = Linkscape::Resource.collection_path({:site => "seomoz.org", :sort => :bad, :Sort => :good})
       path.should == "/linkscape/resources/seomoz.org?Sort=good"
     end
   
     it "automatically uppercases scope" do
       path = Linkscape::Resource.collection_path({:site => "seomoz.org", :scope => :my_scope})
       path.should == "/linkscape/resources/seomoz.org?Scope=my_scope"
     end
   
     it "should not override an existing Scope property" do
       path = Linkscape::Resource.collection_path({:site => "seomoz.org", :Scope => :good, :scope => :bad})
       path.should == "/linkscape/resources/seomoz.org?Scope=good"
     end
     
     it "throws an ArgumentError when no site is given" do
       expect{ Linkscape::Resource.collection_path}.to raise_error(ArgumentError)
     end
  end
  
  context "generates the correct element path" do
    it "provides the right element path" do
       path = Linkscape::Resource.element_path("seomoz.org")
       path.should == "/linkscape/resources/seomoz.org"
     end

     it "escapes the given site" do
       path = Linkscape::Resource.element_path("seomoz.org/blog")
       path.should == "/linkscape/resources/seomoz.org%2Fblog"
     end
  end
  
  context "interacting with cached offsets" do
    it "does a poor mans cache when no redis is given" do
      Linkscape::Resource.set_cached_max_offset({:site => "test.com"}, 100)
      Linkscape::Resource.get_cached_max_offset({:site => "test.com"}).should == 100
    end
  end
  
  context "hydrating from remote data" do
    
    it "throws ArgumentError when nil is given" do
      expect{ Linkscape::Resource.new.load(nil) }.to raise_error(ArgumentError)
    end
    
    it "it does not error out when an empty hash is given" do
      Linkscape::Resource.new.load({})
    end
    
    it "sets properties that are not normally returned" do
      attributes = {:my_property => :my_value}
      resource = Linkscape::Resource.new
      resource.load(attributes)
      resource.my_property.should == attributes[:my_property]
    end
    
    it "converts and sets properties that are in the mapping file" do
      human = :internal_id
      machine = Linkscape::Fields::HUMAN[human][:key]
      attributes = {machine => :my_value}
      
      resource = Linkscape::Resource.new
      resource.load(attributes)
      resource.attributes[human.to_s].should == attributes[machine]
      resource.attributes[machine.to_s].should be_nil
    end      
  end
  
  context "when creating a pagination key" do
    it "does not include limit and offset" do
      key = Linkscape::Resource.pagination_key({:Limit => 4, :Offset => 5, :property => :value, :site => "test.com"})
      key.should == "/linkscape/resources/test.com?property=value"
    end
    
    it "does not care about ordering" do
      key1 = Linkscape::Resource.pagination_key({:property3 => :value, :my_key => 4, :asomething => :hello, :site => "test.com"})
      key2 = Linkscape::Resource.pagination_key({:asomething => :hello, :property3 => :value, :my_key => 4, :site => "test.com"})
      key1.should == key2
    end
  end
  
  context "when calling count" do
    it "returns nil when caching is not setup" do
      Linkscape::Resource.count("site").should be_nil
    end
    
    it "does not barf when nil is given for params" do
      Linkscape::Resource.count("site", nil).should be_nil
    end
    
    it "raises an ArgumentError when nil is given for site" do
      expect{ Linkscape::Resource.count(nil, nil) }.to raise_error(ArgumentError)
    end
  end
  
  context "paginating without graceful pagination" do
    it "is able to paginate to the first page" do
      payload = [Linkscape::Resource.new, Linkscape::Resource.new]
      test_pagination(payload, 1, 10, "test.com", payload.length)
    end
    
    it "silently calls for the first page when zero is passed for the page number" do
      payload = [Linkscape::Resource.new]
      test_pagination(payload, 0, 10, "test2.com", payload.length)
    end
    
    it "silently calls for the firs page when a negative page number is given" do
      payload = [Linkscape::Resource.new]
      test_pagination(payload, -3, 10, "negative.com", payload.length)
    end
    
    it "does not infer the count when the result size is equal to the limit" do
      payload = [Linkscape::Resource.new]
      test_pagination(payload, 1, 1, "lastpage222.com", nil)
    end
    
    it "does not automatically find last page if no results are returned" do
      payload = []
      test_pagination(payload, 3, 1, "noresults.com", nil)
    end
  end
  
  context "paginating with graceful pagination" do
    it "gracefully finds the last page with even" do
      site = "site.com"
      mock_pagination_response(10, 1, site, [])
      mock_pagination_response(6, 1, site, [])
      mock_pagination_response(3, 1, site, [])
      mock_pagination_response(2, 1, site, [])
      mock_pagination_response(1, 1, site, [Linkscape::Resource.new])
            
      pager = Linkscape::Resource.paginate(10, 1, site, {})

      pager.should_not be_nil
      pager.length.should == 1
      pager.total_entries.should == 1
      pager.per_page.should == 1
      pager.offset.should == 0
    end
    
    it "gracefully finds the last page with odd" do
      site = "lastpage.com"
      mock_pagination_response(11, 1, site, [])
      mock_pagination_response(6, 1, site, [])
      mock_pagination_response(3, 1, site, [])
      mock_pagination_response(2, 1, site, [])
      mock_pagination_response(1, 1, site, [Linkscape::Resource.new])
            
      pager = Linkscape::Resource.paginate(11, 1, site, {})

      pager.should_not be_nil
      pager.length.should == 1
      pager.total_entries.should == 1
      pager.per_page.should == 1
      pager.offset.should == 0
    end
    
    it "returns an empty first page when no results exist" do
      site = "noresultsonfirstpage.com"
      mock_pagination_response(2, 1, site, [])
      mock_pagination_response(1, 1, site, [])
      
      pager = Linkscape::Resource.paginate(2, 1, site, {})
      
      pager.should_not be_nil
      pager.length.should == 0
      pager.total_entries.should == 0
    end
    
    it "gracefully finds the last page going up and down" do
      site = "sitebinarysearch.com"
      payload = [Linkscape::Resource.new]
      
      mock_pagination_response(4, 1, site, [])
      mock_pagination_response(2, 1, site, payload)
      mock_pagination_response(3, 1, site, payload)
      
      pager = Linkscape::Resource.paginate(4, 1, site, {})
      
      pager.should_not be_nil
      pager.length.should == 1
      pager.total_entries.should == 3
    end
  end
end

def test_pagination(payload, page, limit, site, expected_total_entries, graceful = false)
  real_page = page
  real_page = 1 if page <= 0
  mock_pagination_response(page, limit, site, payload)
  pager = Linkscape::Resource.paginate(page, limit, site, {}, graceful)
     
  pager.should_not be_nil
  pager.total_entries.should == expected_total_entries
  pager.per_page.should == limit
  pager.offset.should == (real_page - 1) * limit
  pager.length.should == payload.length
end

def mock_pagination_response(page, limit, site, payload)
  real_page = page
  real_page = 1 if page <= 0
  uri = "http://lsapi.seomoz.com/linkscape/resources/#{site}?Limit=#{limit}&Offset=#{(real_page - 1) * limit}"
  FakeWeb.register_uri(:get, uri, :body => payload.to_json)
end