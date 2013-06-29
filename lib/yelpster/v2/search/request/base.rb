require 'yelpster/v2/request'

module Yelp
  module V2
    module Search
      module Request
        class Base < Yelp::V2::Request
          #------------------------General Search Params -----------------
          # string representing the name of business or search term being
          #requested.
          attr_reader :term

          # integer representing number of business results to return
          attr_reader :limit

          # integer representing number of results to skip (for pagination)
          attr_reader :offset

          # integer for specifying how to sort results
          # Sort Mode:
          #     0 = Best matched (default)
          #     1 = Distance
          #     2 = Highest rated
          # see www.yelp.com/developers/documentation/v2/search_api for more info
          attr_reader :sort

          # string specifying which business category to search in
          # see www.yelp.com/developers/documentation/category_list for list of
          # categories
          attr_reader :category_filter

          # integer specifying the search radius in meters
          attr_reader :radius_filter

          # boolean representing if business has a deal available
          attr_reader :deals_filter
          #---------------------------------------------------------------

          #--------------------------- Locale Params ---------------------
          # string representing default country to use while parsing location field
          attr_reader :cc

          # string representing which language of reviews to return
          attr_reader :lang
          #---------------------------------------------------------------

          def base_url
            'http://api.yelp.com/v2/search'
          end

          def to_yelp_params
            super.merge(:term 	=> term,
                        :limit 	=> limit,
                        :offset => offset,
                        :sort 	=> sort,
                        :category_filter => category_filter,
                        :radius_filter 	=> radius_filter,
                        :deals_filter => deals_filter,
                        :cc 	=> cc,
                        :lang 	=> lang)
          end
        end
      end
    end
  end
end
