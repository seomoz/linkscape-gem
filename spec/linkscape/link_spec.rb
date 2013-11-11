require 'spec_helper'

describe Linkscape::Link do

  before(:all) do
    FakeWeb.allow_net_connect = false
  end

  before do
    Linkscape::Resource.user = nil
    Linkscape::Resource.password = nil
    Linkscape::Resource.reset_crummy_cache
    FakeWeb.clean_registry
  end

  it "can set the values of fields with question marks" do
    link = described_class.new(:http_301? => true)
    link.http_301?.should be_true
  end

  let(:metrics) { double(:metrics) }

  context "calculating 'to page' links" do
    let(:criteria) { { target: 'page' } }

    it "is able to calculate the number of followed links" do
      metrics.stub(num_follow_links_to_page: 100)
      criteria[:filter] = "followed_301"
      result.should == 100
    end

    it "is able to calculate the number of external followed links" do
      metrics.stub(num_external_follow_links_to_page: 100)
      criteria[:filter] = "followed_301"
      criteria[:source] = "external"
      result.should == 100
    end

    it "is able to calculate the number of internal followed links" do
      metrics.stub(num_internal_follow_links_to_page: 5)
      criteria[:filter] = "followed_301"
      criteria[:source] = "internal"
      result.should == 5
    end

    it "is able to calculate the number of nofollow links" do
      metrics.stub(num_nofollow_links_to_page: 100)
      criteria[:filter] = "nofollow"
      result.should == 100
    end

    it "is able to calculate the number of external nofollow links" do
      metrics.stub(num_external_nofollow_links_to_page: 5)
      criteria[:filter] = "nofollow"
      criteria[:source] = "external"
      result.should == 5
    end

    it "is able to calculate nofollow links" do
      metrics.stub(num_internal_nofollow_links_to_page: 4)
      criteria[:filter] = "nofollow"
      criteria[:source] = "internal"
      result.should == 4
    end

    it "is able to calculate internal links" do
      metrics.stub(num_internal_follow_links_to_page: 5)
      criteria[:filter] = "followed_301"
      criteria[:source] = "internal"
      result.should == 5
    end

    it "is able to calculate external links" do
      metrics.stub(num_external_links_to_page: 10)
      criteria[:source] = "external"
      result.should == 10
    end

    it "is able to calculate the number of links" do
      metrics.stub(num_links: 10)
      result.should == 10
    end

    it "is able to get the count from cache" do
      described_class.set_cached_max_offset({ site: 'test.com/' }, 3)
      described_class.theoretical_count('test.com/', {}, Linkscape::UrlMetric.new).should == 3
    end
  end

  context "calculating 'to subdomain' link counts" do
    let(:criteria) { { target: "subdomain" } }

    it "calculates number of followed links" do
      metrics.stub(num_follow_links_to_subdomain: 10)
      criteria[:filter] = "followed_301"
      result.should == 10
    end

    it "calculates the number of external followed links" do
      metrics.stub(num_external_follow_links_to_subdomain: 7)
      criteria[:filter] = "followed_301"
      criteria[:source] = "external"
      result.should == 7
    end

    it "calculates the number of internal followed links" do
      metrics.stub(num_internal_follow_links_to_subdomain: 3)
      criteria[:filter] = "followed_301"
      criteria[:source] = "internal"
      result.should == 3
    end

    it "calculates the number of nofollow links" do
      metrics.stub(num_nofollow_links_to_subdomain: 3)
      criteria[:filter] = "nofollow"
      result.should == 3
    end

    it "calculates the number of external nofolllow links" do
      metrics.stub(num_external_nofollow_links_to_subdomain: 7)
      criteria[:source] = "external"
      criteria[:filter] = "nofollow"
      result.should == 7
    end

    it "calculates the number of internal nofollow links" do
      metrics.stub(num_internal_nofollow_links_to_subdomain: 2)
      criteria[:source] = "internal"
      criteria[:filter] = "nofollow"
      result.should == 2
    end

    it "calculates the number of links" do
      metrics.stub(num_links_to_subdomain: 10)
      result.should == 10
    end

    it "calculates the number of external links" do
      metrics.stub(num_external_links_to_subdomain: 10)
      criteria[:source] = "external"
      result.should == 10
    end

    it "calculates the number of internal links" do
      metrics.stub(num_internal_links_to_subdomain: 3)
      criteria[:source] = "internal"
      result.should == 3
    end
  end

  context "calculating 'to domain' link counts" do
    let(:criteria) { { target: 'domain' } }

    it "calculates the number of links" do
      metrics.stub(num_links_to_domain: 10)
      result.should == 10
    end

    it "calculates the number of external links" do
      metrics.stub(num_external_links_to_domain: 10)
      criteria[:source] = "external"
      result.should == 10
    end

    it "calculates the number of intenral links" do
      metrics.stub(num_internal_links_to_domain: 3)
      criteria[:source] = "internal"
      result.should == 3
    end

    it "calculates the number of nofollow links" do
      metrics.stub(num_nofollow_links_to_domain: 3)
      criteria[:filter] = "nofollow"
      result.should == 3
    end

    it "calculates the number of nofollow external links" do
      metrics.stub(num_external_nofollow_links_to_domain: 7)
      criteria[:filter] = "nofollow"
      criteria[:source] = "external"
      result.should == 7
    end

    it "calculates the number of internal nofollow links" do
      metrics.stub(num_internal_nofollow_links_to_domain: 2)
      criteria[:filter] = "nofollow"
      criteria[:source] = "internal"
      result.should == 2
    end

    it "calculates the number of followed links" do
      metrics.stub(num_follow_links_to_domain: 10)
      criteria[:filter] = "followed_301"
      result.should == 10
    end

    it "calculates the number of external follow links" do
      metrics.stub(num_external_follow_links_to_domain: 10)
      criteria[:filter] = "followed_301"
      criteria[:source] = "external"
      result.should == 10
    end

    it "calculates the number of internal follow links" do
      metrics.stub(num_internal_follow_links_to_domain: 10)
      criteria[:filter] = "followed_301"
      criteria[:source] = "internal"
      result.should == 10
    end
  end
end

def result
  described_class.theoretical_count("", criteria, metrics)
end
