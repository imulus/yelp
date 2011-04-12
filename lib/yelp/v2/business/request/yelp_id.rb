require 'yelp/request'

class Yelp
  module V2
    module Business
     module Request
       # Describes a request to search for a business review for the business
       # associated with a specific phone number.
       #
       class YelpId < Yelp::Request
         # the phone number of the business to search for, formatted as
         # '1112223333'.  Make sure you don't have any hyphens or parentheses.
         attr_reader :yelp_id
  
         def base_url
           '/v2/business'
         end
  
         def to_yelp_params
           nil
         end
         
       end
     end
   end
  end
end
