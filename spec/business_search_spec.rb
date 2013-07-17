require 'spec_helper'

module Yelp::V2::Search::Request
  describe 'Business Search' do
    let!(:client)   { create_client(AdditionalSpecHelpers::API_V2) }
    let(:latitude)  { 37.782303 }
    let(:longitude) { -122.484101 }
    let(:location)  { {
      'cross_streets'   => '24th Ave & 25th Ave',
      'city'            => 'San Francisco', 
      'display_address' => ['2308 Clement St', '(b/t 24th Ave & 25th Ave)', 'Outer Richmond', 'San Francisco, CA 94121'], 
      'geo_accuracy'    => 8,
      'neighborhoods'   => ['Outer Richmond'], 
      'postal_code'     => '94121', 
      'country_code'    => 'US', 
      'address'         => ['2308 Clement St'], 
      'coordinate'      => {'latitude' => latitude, 'longitude' => longitude},
      'state_code'      => 'CA'
    } }

    describe 'by Bounding Box' do
      it 'returns businesses within a bounding box' do
        request = BoundingBox.new(
          :sw_latitude     => 37.9,
          :sw_longitude    => -122.5,
          :ne_latitude     =>  37.788022,
          :ne_longitude    => -122.399797,
          :term            => 'yelp',
          :consumer_key    => Credentials.consumer_key,
          :consumer_secret => Credentials.consumer_secret,
          :token           => Credentials.token,
          :token_secret    => Credentials.token_secret)
        expect(client.search(request)).to be_valid_response_hash
      end
    end

    describe 'by GeoPoint' do
      it 'returns business at geo point' do
        request = GeoPoint.new(:latitude        => latitude,
                               :longitude       => longitude,
                               :consumer_key    => Credentials.consumer_key,
                               :consumer_secret => Credentials.consumer_secret,
                               :token           => Credentials.token,
                               :token_secret    => Credentials.token_secret)
        response = client.search(request)
        expect(response).to be_valid_response_hash
        expect(response['businesses'].first['location']).to eq(location)
      end
    end

    describe 'by Location' do
      it 'by Location' do
        request = Location.new(:address         => '2308 Clement St',
                               :city            => 'San Francisco',
                               :state           => 'CA',
                               :zipcode         => 94121,
                               :consumer_key    => Credentials.consumer_key,
                               :consumer_secret => Credentials.consumer_secret,
                               :token           => Credentials.token,
                               :token_secret    => Credentials.token_secret)
        response = client.search(request)
        expect(response).to be_valid_response_hash
        expect(response['businesses'].first['location']['postal_code']).to eq('94121')
      end
    end
  end
end
