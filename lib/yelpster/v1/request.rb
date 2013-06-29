require 'yelpster/record'
require 'open-uri'
require 'zlib'

module Yelp
  module V1
    class Request < Yelp::Record
      # specifies whether the response content should be transmitted
      # over the wire compressed, defaulting to true.
      attr_reader :compress_response

      # one of the Yelp::ResponseFormat format specifiers detailing the
      # desired format of the search results, defaulting to
      # Yelp::ResponseFormat::JSON_TO_RUBY.
      attr_reader :response_format

      # the Yelp Web Services ID to be passed with the request for
      # authentication purposes.  See http://www.yelp.com/developers/getting_started/api_access
      # to get your own.
      attr_reader :yws_id

      alias :compress_response? :compress_response

      def initialize (params)
        default_params = {
          :compress_response => true,
          :response_format => Yelp::ResponseFormat::JSON_TO_RUBY
        }
        super(default_params.merge(params))
      end

      def to_yelp_params
        params = {
          :ywsid => yws_id
        }

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
        source = open(url, http_params)
        content = (compress_response?) ? Zlib::GzipReader.new(source).read : source.read
      end
    end
  end
end
