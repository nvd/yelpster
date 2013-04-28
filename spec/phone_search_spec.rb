require 'spec_helper'

describe 'Search by phone number' do
  let!(:client) { create_client(AdditionalSpecHelpers::API_V1) }

  it 'returns business with specified phone number' do
    request = Yelp::V1::Phone::Request::Number.new(phone_number: '4155666011', yws_id: @yws_id)
    expect(client.search(request)).to be_valid_response_hash
  end
end
