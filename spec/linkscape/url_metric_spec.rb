require 'spec_helper'

describe Linkscape::UrlMetric do
  
  it "knows when it is not found when nothing has been loaded" do
    Linkscape::UrlMetric.new.is_found?.should_not be_true
  end
  
  it "is not found when the magic not found id is present" do
    Linkscape::UrlMetric.new({:internal_id => Linkscape::UrlMetric::NOT_FOUND_ID}).is_found?.should_not be_true
  end
  
  it "knows when it is found" do
    Linkscape::UrlMetric.new({:internal_id => 389393838}).is_found?.should be_true
  end
  
  it "is canonical when IDs match" do
    Linkscape::UrlMetric.new({:internal_id => 7, :canonical_internal_id => 7}).is_canonical?.should be_true
  end
  
  it "is not canonical when IDs dont match" do
    Linkscape::UrlMetric.new({:internal_id => 7, :canonical_internal_id => 8}).is_canonical?.should_not be_true
  end
  
  it "is not canonical when data is not populated" do
    Linkscape::UrlMetric.new().is_canonical?.should_not be_true
  end
  
  context "calculating 'to page' metrics" do
    
    it "is able to calculate the number of followed links to page" do
      metrics = Linkscape::UrlMetric.new({:ujid => 100})
      metrics.num_follow_links_to_page.should == 100
    end
    
    it "is able to calculate the number of external followed links to page" do
      metrics = Linkscape::UrlMetric.new({:ueid => 100})
      metrics.num_external_follow_links_to_page.should == 100
    end
    
    it "is able to calculate the number of internal followed links to page" do
      metrics = Linkscape::UrlMetric.new({:ueid => 5, :ujid => 10})
      metrics.num_internal_follow_links_to_page.should == 5
    end
    
    it "is able to calculate the number of nofollow links to page" do
      metrics = Linkscape::UrlMetric.new({:uid => 10, :ujid => 5})
      metrics.num_nofollow_links_to_page.should == 5
    end
    
    it "is able to calculate the number of external nofollow links to page" do
      metrics = Linkscape::UrlMetric.new({:ued => 10, :ueid => 5})
      metrics.num_external_nofollow_links_to_page.should == 5
    end
    
    it "is able to calculate internal nofollow links to page" do
      metrics = Linkscape::UrlMetric.new({:ued => 10, :ueid => 5, :uid => 10, :ujid => 1})
      metrics.num_internal_nofollow_links_to_page.should == 4
    end
    
    it "is able to calculate the number of internal links" do
      metrics = Linkscape::UrlMetric.new({:uid => 10, :ued => 5})
      metrics.num_internal_links_to_page.should == 5
    end
    
    it "is able to calculate the number of external links" do
      metrics = Linkscape::UrlMetric.new({:ued => 2})
      metrics.num_external_links_to_page.should == 2
    end
    
    it "is able to calculate the number of links" do
      metrics = Linkscape::UrlMetric.new({:uid => 10})
      metrics.num_links.should == 10
    end
  end
  
  context "when calculating to subdomain link counts" do
    it "calculates number of followed links" do
      metrics = Linkscape::UrlMetric.new({:fjid => 10})
      metrics.num_follow_links_to_subdomain.should == 10
    end
    
    it "calculates the number of external followed links" do
      metrics = Linkscape::UrlMetric.new({:feid => 7, :fjid => 10})
      metrics.num_external_follow_links_to_subdomain.should == 7
    end
    
    it "calculates the number of internal followed links" do
      metrics = Linkscape::UrlMetric.new({:feid => 7, :fjid => 10})
      metrics.num_internal_follow_links_to_subdomain.should == 3
    end
    
    it "calculates the number of nofollow links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10, :fjid => 7})
      metrics.num_nofollow_links_to_subdomain.should == 3
    end
    
    it "calculates the number of external nofolllow links" do
      metrics = Linkscape::UrlMetric.new({:feid => 3, :fed => 10})
      metrics.num_external_nofollow_links_to_subdomain.should == 7
    end
    
    it "calculates the number of internal nofollow links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10, :fjid => 1, :fed => 10, :feid => 3})
      metrics.num_internal_nofollow_links_to_subdomain.should == 2
    end
    
    it "calculates the number of links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10})
      metrics.num_links_to_subdomain.should == 10
    end
    
    it "calculates the number of external links" do
      metrics = Linkscape::UrlMetric.new({:fed => 10})
      metrics.num_external_links_to_subdomain.should == 10
    end
    
    it "calculates the number of internal links" do
      metrics = Linkscape::UrlMetric.new({:fuid => 10, :fed => 7})
      metrics.num_internal_links_to_subdomain.should == 3
    end
  end
  
  context "when calculating to domain counts" do
    it "calculates the number of links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10})
      metrics.num_links_to_domain.should == 10
    end
    
    it "calculates the number of external links" do
      metrics = Linkscape::UrlMetric.new({:ped => 10})
      metrics.num_external_links_to_domain.should == 10
    end
    
    it "calculates the number of intenral links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10, :ped => 7})
      metrics.num_internal_links_to_domain.should == 3
    end
    
    it "calculates the number of nofollow links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10, :pjid => 7})
      metrics.num_nofollow_links_to_domain.should == 3
    end
    
    it "calculates the number of nofollow external links" do
      metrics = Linkscape::UrlMetric.new({:peid => 3, :ped => 10})
      metrics.num_external_nofollow_links_to_domain.should == 7
    end
    
    it "calculates the number of internal nofollow links" do
      metrics = Linkscape::UrlMetric.new({:puid => 10, :pjid => 1, :ped => 10, :peid => 3})
      metrics.num_internal_nofollow_links_to_domain.should == 2
    end
    
    it "calculates the number of followed links" do
      metrics = Linkscape::UrlMetric.new({:pjid => 10})
      metrics.num_follow_links_to_domain.should == 10
    end
    
    it "calculates the number of external follow links" do
      metrics = Linkscape::UrlMetric.new({:peid => 10})
      metrics.num_external_follow_links_to_domain.should == 10
    end
    
    it "calculates the number of internal follow links" do
      metric = Linkscape::UrlMetric.new({:pjid => 10, :peid => 7})
      metric.num_internal_follow_links_to_domain.should == 3
    end
  end
end