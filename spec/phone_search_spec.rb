require 'spec_helper'

module Yelp::V1::Phone::Request
  describe 'Search by phone number' do
    before(:all) { Yelp.configure(yws_id: Credentials.yws_id) }
    let(:client) { Yelp::Base.client }

    it 'returns business with specified phone number' do
      request = Number.new(:phone_number => '4155666011')
      expect(client.search(request)).to be_valid_response_hash
    end
  end
end
