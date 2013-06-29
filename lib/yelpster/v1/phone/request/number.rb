require 'yelpster/v1/request'

module Yelp
  module V1
    module Phone
      module Request
        # Describes a request to search for a business review for the business
        # associated with a specific phone number.
        #
        class Number < Yelp::V1::Request
          # the phone number of the business to search for, formatted as
          # '1112223333'.  Make sure you don't have any hyphens or parentheses.
          attr_reader :phone_number

          def base_url
            'http://api.yelp.com/phone_search'
          end

          def to_yelp_params
            super.merge(:phone => phone_number)
          end
        end
      end
    end
  end
end
