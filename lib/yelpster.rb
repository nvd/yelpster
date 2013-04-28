require 'yelpster/client'
require 'yelpster/record'
require 'yelpster/response_format'
#-----------------V1---------------------------
require 'yelpster/v1/request'
require 'yelpster/v1/neighborhood/request/base'
require 'yelpster/v1/neighborhood/request/geo_point'
require 'yelpster/v1/neighborhood/request/location'
require 'yelpster/v1/phone/request/number'
require 'yelpster/v1/review/request/base'
require 'yelpster/v1/review/request/bounding_box'
require 'yelpster/v1/review/request/geo_point'
require 'yelpster/v1/review/request/location'
#----------------V2----------------------------
require 'yelpster/v2/request'
require 'yelpster/v2/business/request/id'
require 'yelpster/v2/search/request/base'
require 'yelpster/v2/search/request/geo_point'
require 'yelpster/v2/search/request/bounding_box'
require 'yelpster/v2/search/request/location'

class Yelp
  VERSION = '1.1.2'
end
