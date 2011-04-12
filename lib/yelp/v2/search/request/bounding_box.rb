require 'yelp/v2/search/request/base'

class Yelp
  module V2
    module Search
      module Request
        # Describes a request to search for business reviews for businesses
        # within a geo-point-specific bounding box
        class BoundingBox < Yelp::V2::Search::Request::Base
          
          # southwest latitude of bounding box
          attr_reader :southwest_latitude
          
          # southwest longitude of bounding box
          attr_reader :southwest_longitude
          
          # northeast latitude of bounding box
          attr_reader :northeast_latitude
          
          # northeast longitude of bounding box
          attr_reader :northeast_longitude
    
          def to_yelp_params
            super.merge(:bounds => "#{southwest_latitude},#{southwest_longitude}|#{northeast_latitude},#{northeast_longitude}")
          end
        end
      end
    end
  end
end