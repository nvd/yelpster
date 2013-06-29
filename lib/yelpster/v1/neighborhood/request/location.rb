require 'yelpster/v1/neighborhood/request/base'

module Yelp
  module V1
    module Neighborhood
      module Request
        # Describes a request to search for a neighborhood name for a specific
        # address/location.  You do not need to specify all of the address
        # attributes -- some subset of the core +address+, +city+,
        # +state+ and +zipcode+ will suffice.
        #
        class Location < Yelp::V1::Neighborhood::Request::Base
          # the street address of the location sought
          attr_reader :address

          # the city of the location sought
          attr_reader :city

          # the state of the location sought
          attr_reader :state

          # the zipcode of the location sought
          attr_reader :zipcode

          def initialize (params)
            # we explicitly initialize the location fields since we reference
            # them later when building a full location string and we want
            # to know they were initialized properly (and avoid warnings)
            super({
              :address => nil,
              :city => nil,
              :state => nil,
              :zipcode => nil
            }.merge(params))
          end

          def to_yelp_params
            super.merge(:location => build_location_string)
          end

          protected

          # Returns the Yelp-compatible concatenated string with the various
          # possible bits of an address-oriented location.
          #
          def build_location_string
            # per the Yelp documentation, the location string is to be built
            # as some combination of "address, city, state, or zip".
            [ @address, @city, @state, @zipcode ].compact.join(',')
          end
        end
      end
    end
  end
end
