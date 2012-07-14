require 'pp'

module YelpHelper
  API_V1 = 'v1'
  API_V2 = 'v2'
  
  def create_client(api_ver)
    @client = Yelp::Client.new
    @api_ver = api_ver

    case @api_ver
    when API_V1
      assert_not_nil(ENV['YWSID'], "Missing YWSID.  Obtain from http://www.yelp.com/developer and " +
                     "set in your shell environment under 'YWSID'.")
      @yws_id = ENV['YWSID']
    when API_V2
      assert_not_nil(ENV['YELP_CONSUMER_KEY'], "Missing YELP_CONSUMER_KEY.  Obtain from http://www.yelp.com/developer and " +
                     "set in your shell environment under 'CONSUMER_KEY'.")
      @consumer_key = ENV['YELP_CONSUMER_KEY']
      assert_not_nil(ENV['YELP_CONSUMER_SECRET'], "Missing YELP_CONSUMER_SECRET.  Obtain from http://www.yelp.com/developer and " +
                     "set in your shell environment under 'CONSUMER_SECRET'.")
      @consumer_secret = ENV['YELP_CONSUMER_SECRET']
      assert_not_nil(ENV['YELP_TOKEN'], "Missing YELP_TOKEN.  Obtain from http://www.yelp.com/developer and " +
                     "set in your shell environment under 'TOKEN'.")
      @token = ENV['YELP_TOKEN']
      assert_not_nil(ENV['YELP_TOKEN_SECRET'], "Missing YELP_TOKEN_SECRET.  Obtain from http://www.yelp.com/developer and " +
                     "set in your shell environment under 'TOKEN_SECRET'.")
      @token_secret = ENV['YELP_TOKEN_SECRET']
    else
      assert_false("No api version specified in test case; cannot continue")
    end
    
#    @client.debug = true
  end

  def validate_json_response (response)
    assert_not_nil response
    assert_instance_of String, response
    assert_match(/^\{\"message\":\{\"text\":\"OK\",\"code\":0,\"version\":\"1\.1\.1\"\},\"(businesses|neighborhoods)\":.*?\}$/, response)
  end

  def validate_json_to_ruby_response (response)
    assert_not_nil response
    assert_instance_of Hash, response
    case @api_ver
    when API_V1
      assert_not_nil response['message']
      assert(response['message']['code'] == 0)
      assert(response['message']['text'] == 'OK')
    when API_V2
      # v2 responses do not have a message field
    end
    assert_not_nil((response['businesses'] || response['neighborhoods']))
    if response['businesses']
      response['businesses'].each { |b| validate_json_to_ruby_business(b) }
    end
  end

  #YELP_BIZ_ID_LENGTH = 22

  def validate_json_to_ruby_business (business)
    # rudimentary checks to make sure it looks like a typical yelp business
    # result converted to a ruby hash
    assert business['id'].length > 0
    assert_valid_url business['url']
  end

  # just a rudimentary check will serve us fine
  VALID_URL_REGEXP = /^https?:\/\/[a-z0-9]/i

  def assert_valid_url (url)
    assert_match VALID_URL_REGEXP, url
  end
end
