require 'spec_helper'

module Yelp::V1::Neighborhood::Request
  describe 'Neighborhood Search' do
    let!(:client) { create_client(AdditionalSpecHelpers::API_V1) }

    describe 'by GeoPoint' do
      it 'returns neighbourhoods at point' do
        request = GeoPoint.new(:latitude => 37.782093,
                               :longitude => -122.483230,
                               :yws_id => @yws_id)
        response = client.search(request)
        expect(response).to be_valid_response_hash
        expect(response['neighborhoods'].first['name']).to eq('Outer Richmond')
      end
    end

    describe 'by Location' do
      it 'returns neighbourhoods at location' do
        request = Location.new(:address => '2252 Clement Street',
                               :city => 'San Francisco',
                               :state => 'CA',
                               :zipcode => 94121,
                               :yws_id => @yws_id)
        response = client.search(request)
        expect(response).to be_valid_response_hash
        expect(response['neighborhoods'].first['name']).to eq('Outer Richmond')
      end
    end
  end
end
