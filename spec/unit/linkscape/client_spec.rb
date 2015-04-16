require 'spec_helper'
require 'linkscape/client'

module Linkscape
  describe Client do
    describe "initialize" do

      let(:any_id) { "test_id" }
      let(:any_secret) { "test_secret" }

      def option_expectations(options)
        expect(options[:apiHost]).to eq('lsapi.seomoz.com')
        expect(options[:apiRoot]).to eq('linkscape')
        expect(options[:accessID]).to eq(any_id)
        expect(options[:secretKey]).to eq(any_secret)
      end

      it "should initialize with access id, and secret key" do
        options = Client.new(any_id, any_secret).options
        option_expectations(options)
      end

      [[:id, :secret], [:ID, :secretKey], [:accessID, :key]].each do |id, key|
        it "should initialize with an options hash (#{id}, #{key})" do
          options = Client.new(id => any_id, key => any_secret).options
          option_expectations(options)
        end
      end

      it "should allow the addition of extra options" do
        options = Client.new(accessID: any_id, secretKey: any_secret, nar: "nar").options
        option_expectations(options)
        expect(options[:nar]).to eq("nar")
      end
    end
  end
end
