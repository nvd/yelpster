require 'yelpster/v2/search/request/base'

module Yelp
  module V2
	  module Search
    		module Request
    		  # Describes a request to search for a businesses by a 
    		  # address/location.  You do not need to specify all of the address
    		  # attributes -- some subset of the core 
    		  # 			address, neighborhood, city, state or zip, optional country
    		  #
    		  class Location < Yelp::V2::Search::Request::Base
    		    # NOTE: At least one of address, neighborhood, city, state, 
    		    # zipcode or country must be specified

      			# string representing the street address of the location sought
      			attr_reader :address
			
      			# string representing the neighborhood of the location sought
      			attr_reader :neighborhood

      			# string representing the city of the location sought
      			attr_reader :city

      			# string representing the state of the location sought
      			attr_reader :state

      			# string representing the zipcode of the location sought
      			attr_reader :zipcode
			
      			# string representing the country of the location sought
      			attr_reader :country
			
      			# additional attributes that can be specified = latitude + longitude
      			attr_reader :latitude
      			attr_reader :longitude

      			def initialize (params)
      			  # we explicitly initialize the location fields since we reference
      			  # them later when building a full location string and we want
      			  # to know they were initialized properly (and avoid warnings)
      			  super({ :address 		  => nil,
        				      :neighborhood => nil,
        				      :city 			  => nil,
        				      :state 			  => nil,
        				      :zipcode 		  => nil,
        				      :country 		  => nil,
        				      :latitude 	  => nil,
        				      :longitude 	  => nil
        			}.merge(params))
      			end

      			def to_yelp_params
      			  super.merge(:location => build_location_string,
      						        :cll		  => build_geo_location_string)
      			end
			
      		protected

      			# Returns the Yelp-compatible concatenated string with the various
      			# possible bits of an address-oriented location.
      			#
      			def build_location_string
      				# per the Yelp documentation, the location string is to be built
      				# as some combination of "address, neighborhood, city, state, or zip, country".
      				[ @address, @neighborhood, @city, @state, @zipcode, @country ].compact.join(',')
      			end
			
      			def build_geo_location_string
      				[ @latitude, @longitude ].collect{|var| var || 0}.join(",")
      			end
    		end
      end
    end
  end
end
