require 'yelp/request'

class Yelp
  module V2
    module Search
      module Request
        class Base < Yelp::Request
          # specifies the number of businesses to return in the result set.
          # default is 10.  minimum value is 1 and maximum value is 20.
          attr_reader :business_count
    
          # string representing the name of business or search term being
          # requested.
          attr_reader :term
    
          # optionally narrow the results by one or more categories.
          # may be a single string value, or an Array of multiple values.
          attr_reader :category
          
          #the radius to search (in miles)
          attr_reader :radius
    
          def base_url
            '/v2/search'
          end
    
          def to_yelp_params
            radius_in_meters = nil
            unless radius.nil?
              radius_in_meters = radius * 1609.344 # convert radius to meters
            end
            
            super.merge(:term => term,
                        :limit => business_count,
                        :category_filter => category,
                        :radius_filter => radius_in_meters) 
          end
          
        end
      end
    end
  end
end
