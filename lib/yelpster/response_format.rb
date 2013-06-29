require 'yelpster/record'

module Yelp
  # Describes the available response formats when querying the Yelp web
  # service for results.
  #
  class ResponseFormat < Record
    # the name of the response format
    attr_reader :name
    
    # whether this response format returns serialized data (and, so, data that
    # we probably don't want to print to a log file and suchlike)
    attr_reader :serialized

    # the format specifier to retrieve results as straight JSON content
    JSON = Yelp::ResponseFormat.new(:name => 'json')
  
    # the format specifier to retrieve results as Ruby objects converted
    # from the returned JSON content via the +json+ rubygem.
    JSON_TO_RUBY = Yelp::ResponseFormat.new(:name => 'json_to_ruby')
  
    # the format specifier to retrieve results as a serialized Python
    # response.  We're not quite sure why you'd want to use this if
    # you're calling it from Ruby code, but we like to see completeness
    # in an API.
    PICKLE = Yelp::ResponseFormat.new(:name => 'pickle', :serialized => true)
  
    # the format specifier to retrieve results as a serialized PHP
    # response.  We're not quite sure why you'd want to use this if
    # you're calling it from Ruby code, but we like to see completeness
    # in an API.
    PHP = Yelp::ResponseFormat.new(:name => 'php', :serialized => true)

    alias :serialized? :serialized
  end
end
