require 'yelpster/v1/neighborhood/request/base'

module Yelp
  module V1
    module Neighborhood
      module Request
        # Describes a request to search for the name of a neighborhood at a
        # specific geo-point location.
        #
        class GeoPoint < Yelp::V1::Neighborhood::Request::Base
          # latitude of geo-point for which a neighborhood name is desired
          attr_reader :latitude

          # longitude of geo-point for which a neighborhood name is desired
          attr_reader :longitude

          def to_yelp_params
            super.merge(:lat => latitude,
                        :long => longitude)
          end
        end
      end
    end
  end
end
