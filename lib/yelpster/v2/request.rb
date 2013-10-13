require 'yelpster/record'
require 'oauth'

module Yelp
  module V2
    class Request < Yelp::Record
      # specifies whether the response content should be transmitted
      # over the wire compressed, defaulting to true.
      attr_reader :compress_response

      # one of the Yelp::ResponseFormat format specifiers detailing the
      # desired format of the search results, defaulting to
      # Yelp::ResponseFormat::JSON_TO_RUBY.
      attr_reader :response_format

      # the Yelp consumer_key, consumer_secret, token, token_secret to be passed with the request for
      # authentication purposes. See http://www.yelp.com/developers/getting_started/api_access
      # to get your own.
      attr_reader :consumer_key
      attr_reader :consumer_secret
      attr_reader :token
      attr_reader :token_secret

      alias :compress_response? :compress_response

      def initialize (params)
        default_params = {
          :compress_response => true,
          :response_format => Yelp::ResponseFormat::JSON_TO_RUBY
        }
        super(default_params.merge(params))
      end

      def to_yelp_params
        params = {}

        # if they specified anything other than a json variant, we
        # need to tell yelp what we're looking for
        case @response_format
        when Yelp::ResponseFormat::PICKLE
          params[:output] = 'pickle'
        when Yelp::ResponseFormat::PHP
          params[:output] = 'php'
        end

        params
      end

      def pull_results (url, http_params)
        consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://api.yelp.com"})
        access_token = OAuth::AccessToken.new(consumer, token, token_secret)
        access_token.get(url).body
      end

      # For backwards compatibility
      def consumer_key
        @consumer_key || Yelp::Base.client.consumer_key
      end

      def consumer_secret
        @consumer_secret || Yelp::Base.client.consumer_secret
      end

      def token
        @token || Yelp::Base.client.token
      end

      def token_secret
        @token_secret || Yelp::Base.client.token_secret
      end
    end
  end
end
