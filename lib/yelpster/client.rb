require 'cgi'
require 'logger'
require 'rubygems'
require 'json'
require 'yaml'

module Yelp
  # Provides access to the Yelp search facilities as documented at:
  #
  # http://www.yelp.com/developers/documentation
  #
  # Example usage:
  #
  #    client = Yelp::Client.new
  #    request = Yelp::V1::Review::Request::Location.new(
  #                 :address => '650 Mission St',
  #                 :city => 'San Francisco',
  #                 :state => 'CA',
  #                 :radius => 2,
  #                 :term => 'cream puffs',
  #                 :yws_id => 'YOUR_YWSID_HERE')
  #    response = client.search(request)
  #
  # By default, response content is formatted as a Ruby hash converted from
  # Yelp's source JSON response content.  Alternate response formats can be
  # specified on request record construction via the Yelp::Request
  # +response_format+ parameter, available in all request record types.
  #
  class Client
    # allows specifying the user agent string to submit with search requests
    attr_accessor :agent

    # whether debug mode is enabled for logging purposes, defaulting to false
    attr_accessor :debug

    # the Logger compatible object with which log messages are outputted,
    # defaulting to output to STDOUT
    attr_accessor :logger

    attr_accessor :yws_id, :consumer_key, :consumer_secret, :token, :token_secret

    # the default user agent submitted with search requests
    DEFAULT_AGENT = 'yelp for Ruby (http://www.rubyforge.org/projects/yelp/)'

    # Constructs a new client that uses the supplied YWSID for submitting
    # search requests.
    #
    def initialize(attributes = {})
      @agent = DEFAULT_AGENT
      @debug = false
      @logger = nil
      attributes.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    # Submits the supplied search request to Yelp and returns the response in
    # the format specified by the request.
    #
    def search (request)
      # build the full set of hash params with which the url is constructed
      params = request.to_yelp_params

      # construct the url with which we obtain results
      url = build_url(request.base_url, params)
      debug_msg "submitting search [url=#{url}, request=#{request.to_yaml}]."

      # submit the http request for the results
      # http_request_params not used in v2 as OAuth (implemented in v2) only takes response params
      http_params = { 'User-Agent' => @agent }
      http_params['Accept-Encoding'] = 'gzip,deflate' if request.compress_response?
      http_params[:proxy] = nil
      content = request.pull_results(url, http_params)

      # read the response content
      debug_msg((request.response_format.serialized?) ? "received response [content_length=#{content.length}]." : "received response [content_length=#{content.length}, content=#{content}].")

      # format the output as specified in the request
      format_content(request.response_format, content)
    end

    protected

    def format_content (response_format, content)
      (response_format == Yelp::ResponseFormat::JSON_TO_RUBY) ? JSON.parse(content) : content
    end

    def debug_msg (message)
      return if !@debug
      @logger = Logger.new(STDOUT) if (!@logger)
      @logger.debug message
    end

    def build_url (base_url, params)
      "#{base_url}?#{to_query_string(params)}"
    end

    def to_query_string(params)
      params.delete_if { |_, v| v.nil? }.
             to_a.
             map { |key, value| "#{escape(key)}=#{escape(value)}" }.
             join('&')
    end

    def escape(object)
      object.kind_of?(Array) ? object.map { |v| CGI.escape(v.to_s) }.join('+') : CGI.escape(object.to_s)
    end
  end
end
