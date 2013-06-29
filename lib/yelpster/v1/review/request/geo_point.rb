require 'yelpster/v1/review/request/base'

module Yelp
  module V1
    module Review
      module Request
        # Describes a request to search for business reviews for businesses near
        # a specific geo-point and radius around that point.
        #
        class GeoPoint < Yelp::V1::Review::Request::Base
          # latitude of geo-point to search near
          attr_reader :latitude

          # longitude of geo-point to search near
          attr_reader :longitude

          # radius to use while searching around specified geo-point.
          # default value is 1, maximum value is 25.
          attr_reader :radius

          def to_yelp_params
            super.merge(:lat => latitude,
                        :long => longitude,
                        :radius => radius)
          end
        end
      end
    end
  end
end
