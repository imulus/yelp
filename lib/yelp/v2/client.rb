require 'yelp/client'

class Yelp
  module V2
    # Provides access to the Yelp search facilities as documented at:
    #
    # http://www.yelp.com/developers/documentation
    #
    # Example usage:
    #
    #    client = Yelp::V2::Client.new(
    #                 :consumer_key => 'consumerKey',
    #                 :consumer_secret => 'consumerSecret'
    #                 :token => 'token',
    #                 :token_secret => 'tokenSecret')
    #    request = Yelp::V2::Search::Request::Location.new(
    #                 :address => '650 Mission St',
    #                 :city => 'San Francisco',
    #                 :state => 'CA',
    #                 :radius => 2,
    #                 :term => 'cream puffs')
    #    response = client.search(request)
    #
    # By default, response content is formatted as a Ruby hash converted from
    # Yelp's source JSON response content.  Alternate response formats can be
    # specified on request record construction via the Yelp::Request
    # +response_format+ parameter, available in all request record types.
    #
    
    class Client < Yelp::Client
    
      attr_accessor :consumer_key, :consumer_secret, :token, :token_secret
    
      def initialize(params)
        @consumer_key = params[:consumer_key]
        @consumer_secret = params[:consumer_secret]
        @token = params[:token]
        @token_secret = params[:token_secret]
      end
      
      # Submits the supplied search request to Yelp and returns the response in
      # the format specified by the request.
      #
      def search (request)
        # build the full set of hash params with which the url is constructed
        params = request.to_yelp_params
    
        # construct the url with which we obtain results
        url = build_url('/v2/search', params)
        puts url
        debug_msg "submitting search [url=#{url}, request=#{request.to_yaml}]."
     
        consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, {:site => "http://api.yelp.com"})
        access_token = OAuth::AccessToken.new(consumer, @token, @token_secret)
        
        puts consumer
        puts access_token
    
        # read the response content
        content = access_token.get(url).body
        debug_msg((request.response_format.serialized?) ? "received response [content_length=#{content.length}]." : "received response [content_length=#{content.length}, content=#{content}].")
    
        # format the output as specified in the request
        format_content(request.response_format, content)
      end
    end
  end
end
