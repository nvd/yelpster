require 'spec_helper'

describe Yelp::Client do
  it 'creates a new client' do
    expect { Yelp::Client.new }.to_not raise_error
  end
end
