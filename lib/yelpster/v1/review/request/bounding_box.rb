require 'yelpster/v1/review/request/base'

module Yelp
  module V1
    module Review
      module Request
        # Describes a request to search for business reviews for businesses
        # within a geo-point-specific bounding box and radius around
        # that box.
        #
        class BoundingBox < Yelp::V1::Review::Request::Base
          # bottom right latitude of bounding box
          attr_reader :bottom_right_latitude

          # bottom right longitude of bounding box
          attr_reader :bottom_right_longitude

          # radius to use while searching around specified geo-point.
          # default value is 1, maximum value is 25.
          attr_reader :radius

          # top left latitude of bounding box
          attr_reader :top_left_latitude

          # top left longitude of bounding box
          attr_reader :top_left_longitude

          def to_yelp_params
            super.merge(:tl_lat => top_left_latitude,
                        :tl_long => top_left_longitude,
                        :br_lat => bottom_right_latitude,
                        :br_long => bottom_right_longitude,
                        :radius => radius)
          end
        end
      end
    end
  end
end
