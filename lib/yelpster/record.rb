module Yelp
  # General-purpose record that allows passing a hash with parameters
  # to populate object attributes defined via methods like
  # +attr_reader+ or +attr_accessor+.
  #
  class Record
    def initialize (params)
      if !params.nil?
        params.each do |key, value| 
          name = key.to_s
          instance_variable_set("@#{name}", value) if respond_to?(name)
        end
      end
    end
  end
end
