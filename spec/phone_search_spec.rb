require 'spec_helper'

module Yelp::V1::Phone::Request
  describe 'Search by phone number' do
    before(:all) { Yelp.configure(:yws_id => Credentials.yws_id) }
    let(:client) { Yelp::Base.client }

    it 'returns business with specified phone number' do
      request = Number.new(:phone_number => '4155666011')
      expect(client.search(request)).to be_valid_response_hash
    end

    it 'returns a business in another country' do
      request = Number.new(:phone_number => '098460655', :cc => 'NZ')
      response = client.search(request)
      expect(response).to be_valid_response_hash
      expect(response['businesses'].count).to eq(1)
    end
  end
end
