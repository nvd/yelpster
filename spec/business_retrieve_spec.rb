require 'spec_helper'

describe 'Find Business by Id' do
  let!(:client) { create_client(AdditionalSpecHelpers::API_V2) }

  subject do
    client.search(Yelp::V2::Business::Request::Id.new(
                    :yelp_business_id => 'pjb2WMwa0AfK3L-dWimO8w',
                    :consumer_key => @consumer_key,
                    :consumer_secret => @consumer_secret,
                    :token => @token,
                    :token_secret => @token_secret))
  end

  it 'returns a valid business hash' do
    subject.should be_valid_business_hash
  end

  it 'returns the correct business' do
    expect(subject['id']).to eq('chocolate-san-francisco')
  end
end
