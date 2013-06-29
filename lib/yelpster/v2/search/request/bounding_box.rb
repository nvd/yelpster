require 'yelpster/v2/search/request/base'

module Yelp
  module V2
    module Search
      module Request
        # Describes a request to search for businesses
        # within a geo-point-specific bounding box
        #
        class BoundingBox < Yelp::V2::Search::Request::Base
          # REQUIRED - double, bottom right latitude of bounding box (SOUTH-WEST LAT)
          attr_reader :sw_latitude

          # REQUIRED - double, bottom right longitude of bounding box (SOUTH-WEST LONG)
          attr_reader :sw_longitude

          # REQUIRED - double, top left latitude of bounding box (NORTH-EAST LAT)
          attr_reader :ne_latitude

          # REQUIRED - double, top left longitude of bounding box (NORTH-EAST LONG)
          attr_reader :ne_longitude

          def to_yelp_params
            super.merge(:bounds => "#{sw_latitude},#{sw_longitude}|#{ne_latitude},#{ne_longitude}")
          end
        end
      end
    end
  end
end
