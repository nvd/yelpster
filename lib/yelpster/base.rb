module Yelp
  class Base
    class << self
      attr_accessor :client
    end

    def self.client
      @client || Base.client
    end
  end
end
