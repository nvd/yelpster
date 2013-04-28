require 'spec_helper'

describe 'Review Search' do
  let!(:client) { create_client(AdditionalSpecHelpers::API_V1) }

  describe 'by Bounding Box' do
    it 'returns reviews in box' do
      request = Yelp::V1::Review::Request::BoundingBox.new(
        :bottom_right_latitude => 37.788022,
        :bottom_right_longitude => -122.399797,
        :top_left_latitude => 37.9,
        :top_left_longitude => -122.5,
        :term => 'yelp',
        :yws_id => @yws_id)
      expect(client.search(request)).to be_valid_response_hash
    end
  end

  describe 'by GeoPoint' do
    it 'returns reviews at point' do
      request = Yelp::V1::Review::Request::GeoPoint.new(
        :latitude => 37.78022,
        :longitude => -122.399797,
        :radius => 2,
        :term => 'yelp',
        :yws_id => @yws_id)
      expect(client.search(request)).to be_valid_response_hash
    end
  end

  describe 'by Location' do
    it 'returns reviews at location' do
      request = Yelp::V1::Review::Request::Location.new(
        :address => '650 Mission St',
        :city => 'San Francisco',
        :state => 'CA',
        :radius => 2,
        :term => 'cream puffs',
        :yws_id => @yws_id)
      expect(client.search(request)).to be_valid_response_hash
    end
  end

  context 'when filtered with category' do
    it 'returns less results than unfiltered search' do
      # perform a basic search of businesses near SOMA
      request = Yelp::V1::Review::Request::GeoPoint.new(
        :latitude => 37.78022,
        :longitude => -122.399797,
        :radius => 5,
        :term => 'yelp',
        :yws_id => @yws_id)
      response = client.search(request)

      # perform the same search focusing only on playgrounds
      narrowed_request = Yelp::V1::Review::Request::GeoPoint.new(
        :latitude => 37.78022,
        :longitude => -122.399797,
        :radius => 5,
        :term => 'yelp',
        :category => 'playgrounds',
        :yws_id => @yws_id)
      narrowed_response = client.search(narrowed_request)

      # make sure we got less for the second
      expect(response['businesses'].length).to be > narrowed_response['businesses'].length
    end
  end

  it 'returns valid json' do
    request = basic_request(:response_format => Yelp::ResponseFormat::JSON)
    expect(client.search(request)).to be_valid_json
  end

  it 'returns valid ruby hash' do
    request = basic_request(:response_format => Yelp::ResponseFormat::JSON_TO_RUBY)
    expect(client.search(request)).to be_valid_response_hash
  end

  pending 'returns valid pickle' do
    request = basic_request(:response_format => Yelp::ResponseFormat::PICKLE)
    response = client.search(request)
    # TODO: validation
  end

  pending 'returns valid php' do
    request = basic_request(:response_format => Yelp::ResponseFormat::PHP)
    response = client.search(request)
    # TODO: validation
  end
  
  it 'returns multiple categories' do
    # fetch results for only one category
    params = {
      :city => 'San Francisco',
      :state => 'CA',
      :yws_id => @yws_id,
      :category => 'donuts'
    }
    request = Yelp::V1::Review::Request::Location.new(params)
    response = client.search(request)

    expect(response).to be_valid_response_hash

    # make sure all businesses returned have at least the specified category
    response['businesses'].each do |b|
      cat_exists = b['categories'].find { |c| c['category_filter'] == 'donuts' }
      expect(cat_exists).to_not be_nil
    end

    # now fetch for businesses with two categories
    params[:category] = [ 'donuts', 'icecream' ]
    request = Yelp::V1::Review::Request::Location.new(params)
    response = client.search(request)

    expect(response).to be_valid_response_hash

    # make sure we have at least one of each specified category, and
    # that each business has at least one
    donut_count = 0
    icecream_count = 0
    response['businesses'].each do |b|
      has_donut = b['categories'].find { |c| c['category_filter'] == 'donuts' }
      has_icecream = b['categories'].find { |c| c['category_filter'] == 'icecream' }

      donut_count += 1 if has_donut
      icecream_count += 1 if has_icecream

      expect(has_donut || has_icecream).to_not be_nil
    end

    expect((donut_count > 0) && (icecream_count > 0)).to be_true
  end

  private
  def basic_request(options = {})
    default_params = {
      :city => 'San Francisco',
      :state => 'CA',
      :term => 'gordo',
      :yws_id => @yws_id
    }
    Yelp::V1::Review::Request::Location.new(default_params.merge(options))
  end
end
