require 'yelpster/v2/request'

module Yelp
  module V2
    module Business
      module Request
        class Id < Yelp::V2::Request
          # the alphanumeric id of the business to search for as provided by yelp,
          # eg: 'pjb2WMwa0AfK3L-dWimO8w'
          attr_reader :yelp_business_id

          def base_url
            'http://api.yelp.com/v2/business/'+yelp_business_id
          end
        end
      end
    end
  end
end
