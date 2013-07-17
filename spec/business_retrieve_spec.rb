require 'spec_helper'

module Yelp::V2::Business::Request
  describe Id do
    let!(:client) { create_client(AdditionalSpecHelpers::API_V2) }

    subject do
      client.search(Id.new(
        :yelp_business_id => 'pjb2WMwa0AfK3L-dWimO8w',
        :consumer_key => Credentials.consumer_key,
        :consumer_secret => Credentials.consumer_secret,
        :token => Credentials.token,
        :token_secret => Credentials.token_secret))
    end

    it 'returns a valid business hash' do
      subject.should be_valid_business_hash
    end

    it 'returns the correct business' do
      expect(subject['id']).to eq('chocolate-san-francisco')
    end
  end
end
