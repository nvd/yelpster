ENV["RAILS_ENV"] ||= 'test'
require 'rspec/autorun'
require 'yelpster'
require 'json'

module AdditionalSpecHelpers
  API_V1 = 'v1'
  API_V2 = 'v2'

  def create_client(api_ver)
    client = Yelp::Client.new

    case api_ver
    when API_V1
      ENV['YWSID'].should_not be_nil, "Missing YWSID. Obtain from http://www.yelp.com/developers and set in your shell environment under 'YWSID'."
      @yws_id = ENV['YWSID']
    when API_V2
      ENV['YELP_CONSUMER_KEY'].should_not be_nil, "Missing YELP_CONSUMER_KEY. Obtain from http://www.yelp.com/developers and set in your shell environment under 'YELP_CONSUMER_KEY'."
      @consumer_key = ENV['YELP_CONSUMER_KEY']

      ENV['YELP_CONSUMER_SECRET'].should_not be_nil, "Missing YELP_CONSUMER_SECRET. Obtain from http://www.yelp.com/developers and set in your shell environment under 'YELP_CONSUMER_SECRET'."
      @consumer_secret = ENV['YELP_CONSUMER_SECRET']

      ENV['YELP_TOKEN'].should_not be_nil, "Missing YELP_TOKEN. Obtain from http://www.yelp.com/developers and set in your shell environment under 'YELP_TOKEN'."
      @token = ENV['YELP_TOKEN']

      ENV['YELP_TOKEN_SECRET'].should_not be_nil, "Missing YELP_TOKEN_SECRET. Obtain from http://www.yelp.com/developers and set in your shell environment under 'YELP_TOKEN_SECRET'."
      @token_secret = ENV['YELP_TOKEN_SECRET']
    else
      assert_false('No api version specified in test case; cannot continue')
    end
    # client.debug = true
    client
  end

end

#TODO: These matchers are quite lame and need to meaningfully test
# No point in testing ruby conversion of json to hashes

RSpec::Matchers.define :be_valid_json do
  match do |actual|
    begin
      JSON.parse(actual) && true
    rescue JSON::ParserError
      false
    end
  end
end

RSpec::Matchers.define :be_valid_business_hash do
  match do |business|
    expect(business['id'].length).to be > 0
    expect(business['url']).to match_regex(/^https?:\/\/[a-z0-9]/i)
  end
end

RSpec::Matchers.define :be_valid_response_hash do
  match do |response|
    expect(response).to_not be_nil
    expect(response['businesses'] || response['neighborhoods']).to_not be_nil
    if(response['businesses'])
      # TODO: loop in a test? - should just pick one if at all
      response['businesses'].each { |b| expect(b).to be_valid_business_hash }
    else
      true
    end
  end
end

RSpec.configure do |config|
  config.include AdditionalSpecHelpers
end
