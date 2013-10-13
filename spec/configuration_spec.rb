require 'spec_helper'

describe 'Configuration' do
  describe 'per request (for backwards compatibility)' do
    it 'configures correctly on V1 request' do
      client = create_client(AdditionalSpecHelpers::API_V1)
      request = Yelp::V1::Neighborhood::Request::Location.new(
                             :address => '2252 Clement Street',
                             :city    => 'San Francisco',
                             :state   => 'CA',
                             :zipcode => 94121,
                             :yws_id  => Credentials.yws_id)
      expect(client.search(request)).to be_valid_response_hash
    end

    it 'configures correctly on V2' do
      client = create_client(AdditionalSpecHelpers::API_V2)
      request = Yelp::V2::Business::Request::Id.new(
                      :yelp_business_id => 'pjb2WMwa0AfK3L-dWimO8w',
                      :consumer_key     => Credentials.consumer_key,
                      :consumer_secret  => Credentials.consumer_secret,
                      :token            => Credentials.token,
                      :token_secret     => Credentials.token_secret)
      expect(client.search(request)).to be_valid_business_hash
    end
  end
end
