require 'yelpster/v1/request'

module Yelp
  module V1
    module Review
      module Request
        class Base < Yelp::V1::Request
          # specifies the number of businesses to return in the result set.
          # default is 10.  minimum value is 1 and maximum value is 20.
          attr_reader :business_count

          # string representing the name of business or search term being
          # requested.
          attr_reader :term

          # optionally narrow the results by one or more categories.
          # may be a single string value, or an Array of multiple values.
          attr_reader :category

          def base_url
            'http://api.yelp.com/business_review_search'
          end

          def to_yelp_params
            super.merge(:term => term,
                        :num_biz_requested => business_count,
                        :category => category)
          end
        end
      end
    end
  end
end
