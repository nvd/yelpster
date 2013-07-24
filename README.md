## Yelpster

[![Build Status](https://travis-ci.org/nvd/yelpster.png?branch=develop)](https://travis-ci.org/nvd/yelpster)

A Ruby object-oriented interface to the local business content available
on Yelp at http://www.yelp.com.  Functionality is provided to perform
all searches available via the developer API including:

* search for business reviews by geo-bounding-box, geo-point, or address/location.
* search for a business review by business phone number.
* search for a neighborhood by geo-point or address/location.
* search for business details by geo-bounding-box, geo-point, or address/location.
* retrieval of business details by specifying yelp id of business

More detailed information on the underlying Yelp API, error response codes, and so forth is available at http://www.yelp.com/developers/getting_started.

This documentation is available at http://rubydoc.info/github/nvd/yelpster.

The latest source code is at http://github.com/nvd/yelpster.

## Requirements

You must have a Yelp Web Service ID (YWSID) if you're using v1 of the api or Consumer Key, Consumer Secret, Token and a Token Secret for version 2. These are available at http://www.yelp.com/developers/getting_started/api_access.

You must conform to the Yelp Branding Requirements when making use of content
retrieved via their API, documented at http://www.yelp.com/developers/getting_started/api_branding.

For tests to execute successfully you must have the YWSID (for v1) or YELP_CONSUMER_KEY, YELP_CONSUMER_SECRET, YELP_TOKEN and YELP_TOKEN_SECRET(for v2) set in your environment via (shell-dependent, bash example provided):

```console
 % export YWSID='YOUR_ID_HERE'
```

or

```console
 % export YELP_CONSUMER_KEY='YOUR_CONSUMER_KEY_HERE'
 % export YELP_CONSUMER_SECRET='YOUR_CONSUMER_SECRET_HERE'
 % export YELP_TOKEN='YOUR_TOKEN_HERE'
 % export YELP_TOKEN_SECRET='YOUR_TOKEN_SECRET_HERE'
```

## Installing

```console
 % gem install yelpster
```

## Usage

Instantiate a Yelp::Client and use its ```search``` method to make requests of
the Yelp server.

The available search request types are:

* Yelp::V1::Review::Request::BoundingBox
* Yelp::V1::Review::Request::GeoPoint
* Yelp::V1::Review::Request::Location
* Yelp::V1::Phone::Request::Number
* Yelp::V1::Neighborhood::Request::GeoPoint
* Yelp::V1::Neighborhood::Request::Location
* Yelp::V2::Business::Request::Id
* Yelp::V2::Search::Request::BoundingBox
* Yelp::V2::Search::Request::GeoPoint
* Yelp::V2::Search::Request::Location

You can ```include``` the overlying module to cut back on typing
or in case of conflicts between classes, use the fully qualified search request class name.

By default, response content is formatted as a Ruby hash converted from Yelp's
source JSON response content. Alternate response formats (including the
original pure JSON) can be specified on request record construction via the
Yelp::[V1/V2]::Request ```response_format``` parameter, available in all request record
types.

A few examples:

```ruby
 # construct a client instance
 client = Yelp::Client.new

 include Yelp::V1::Review::Request
 # perform an address/location-based search for cream puffs nearby
 request = Location.new(
             :address => '650 Mission St',
             :city => 'San Francisco',
             :state => 'CA',
             :radius => 2,
             :term => 'cream puffs',
             :yws_id => 'YOUR_YWSID_HERE')
 response = client.search(request)

 # perform a location-based category search for either ice cream or donut shops in SF
 request = Location.new(
             :city => 'San Francisco',
             :state => 'CA',
             :category => ['donuts', 'icecream'],
             :yws_id => 'YOUR_YWSID_HERE')
 response = client.search(request)

 # perform a neighborhood name lookup for a specific geo-location point
 request = GeoPoint.new(
             :latitude => 37.782093,
             :longitude => -122.483230,
             :yws_id => 'YOUR_YWSID_HERE')
 response = client.search(request)

 # -------------------------------------------------------

 include Yelp::V1::Phone::Request
 # perform a business review search based on a business phone number
 request = Number.new(
             :phone_number => '4155551212',
             :yws_id => 'YOUR_YWSID_HERE')
 response = client.search(request)

 # -------------------------------------------------------

 include Yelp::V2::Business::Request
 # retrieve details of business vi yelp business id
 request = Id.new(
             :yelp_business_id => "pjb2WMwa0AfK3L-dWimO8w",
             :consumer_key => 'YOUR_CONSUMER_KEY',
             :consumer_secret => 'YOUR_CONSUMER_SECRET',
             :token => 'YOUR_TOKEN',
             :token_secret => 'YOUR_TOKEN_SECRET')
 response = client.search(request)

 # -------------------------------------------------------

 include Yelp::V2::Search::Request
 # search for businesses via bounding box geo coords'
 request = BoundingBox.new(
             :term => "cream puffs",
             :sw_latitude => 37.900000,
             :sw_longitude => -122.500000,
             :ne_latitude => 37.788022,
             :ne_longitude => -122.399797,
             :limit => 3,
             :consumer_key => 'YOUR_CONSUMER_KEY',
             :consumer_secret => 'YOUR_CONSUMER_SECRET',
             :token => 'YOUR_TOKEN',
             :token_secret => 'YOUR_TOKEN_SECRET')
 response = client.search(request)

 # search for businesses via lat/long geo point'
 request = GeoPoint.new(
             :term => "cream puffs",
             :latitude => 37.788022,
             :longitude => -122.399797,
             :consumer_key => 'YOUR_CONSUMER_KEY',
             :consumer_secret => 'YOUR_CONSUMER_SECRET',
             :token => 'YOUR_TOKEN',
             :token_secret => 'YOUR_TOKEN_SECRET')
 response = client.search(request)

 # search for businesses via location (address, neighbourhood, city, state, zip, country, latitude, longitude)'
 request = Location.new(
             :term => "cream puffs",
             :city => "San Francisco",
             :consumer_key => 'YOUR_CONSUMER_KEY',
             :consumer_secret => 'YOUR_CONSUMER_SECRET',
             :token => 'YOUR_TOKEN',
             :token_secret => 'YOUR_TOKEN_SECRET')
 response = client.search(request)

 request = Location.new(
             :term => "german food",
             :address => "Hayes",
             :latitude => 37.77493,
             :longitude => -122.419415,
             :consumer_key => 'YOUR_CONSUMER_KEY',
             :consumer_secret => 'YOUR_CONSUMER_SECRET',
             :token => 'YOUR_TOKEN',
             :token_secret => 'YOUR_TOKEN_SECRET')
 response = client.search(request)
```

If you want to convert some addresses to latitude/longitude, or vice
versa, for testing or what have you -- try http://stevemorse.org/jcal/latlon.php.

## License

This library is provided via the GNU LGPL license at http://www.gnu.org/licenses/lgpl.html.

## Authors

Copyright 2007 - 2009, Walter Korman <shaper@fatgoose.com>, http://lemurware.blogspot.com

2011 – Yelp V2 Additions by Naveed Siddiqui <naveed@10eighteen.com>

