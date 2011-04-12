require 'yelp/v2/search/request/base'

class Yelp
  module V2
    module Search
      module Request
        # Describes a request to search for business reviews for businesses near
        # a specific geo-point 
        
        class GeoPoint < Yelp::V2::Search::Request::Base
          # latitude of geo-point to search near
          attr_reader :latitude
      
          # longitude of geo-point to search near
          attr_reader :longitude
      
          def to_yelp_params
            super.merge(:ll => "#{latitude},#{longitude}")
          end
        end
      end
    end
  end
end
