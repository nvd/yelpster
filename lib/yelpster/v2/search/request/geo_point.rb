require 'yelpster/v2/search/request/base'

module Yelp
  module V2
    module Search
      module Request
        # Describes a request to search for the name of a neighborhood at a
        # specific geo-point location.
        #
        class GeoPoint < Yelp::V2::Search::Request::Base
          # REQUIRED - double, latitude of geo-point to search
          attr_reader :latitude

          # REQUIRED - double, longitude of geo-point to search
          attr_reader :longitude

          # OPTIONAL - double, accuracy of latitude and longitude of geo-point to search
          attr_reader :accuracy

          # OPTIONAL - double, altitude of geo-point to search
          attr_reader :altitude

          # OPTIONAL - double, accuracy of altitude geo-point to search
          attr_reader :altitude_accuracy

          def initialize(params)
            # we explicitly initialize the location fields since we reference
            # them later when building a full location string and we want
            # to know they were initialized properly (and avoid warnings)
            # 50 and -100 default values are provided as they lie within yelp API's geo-location range
            super({
              :latitude	=> 50.0,
              :longitude	=> -100.0,
              :accuracy	=> nil,
              :altitude	=> nil,
              :altitude_accuracy => nil
            }.merge(params))
          end

          def to_yelp_params
            super.merge(:ll => build_geo_loc_string)
          end

          # Returns the Yelp-compatible concatenated string with the various
          # possible bits of an address-oriented location.
          #
          def build_geo_loc_string
            [ @latitude, @longitude, @accuracy, @altitude, @altitude_accuracy ].compact.join(",")
          end
        end
      end
    end
  end
end