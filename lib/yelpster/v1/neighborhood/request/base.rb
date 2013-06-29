require 'yelpster/v1/request'

module Yelp
  module V1
    module Neighborhood
      module Request
        class Base < Yelp::V1::Request
          def base_url
            'http://api.yelp.com/neighborhood_search'
          end
        end
      end
    end
  end
end
