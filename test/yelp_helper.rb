require 'pp'

module YelpHelper
  def create_client
    @client = Yelp::Client.new
    assert_not_nil(ENV['YWSID'], "Missing YWSID.  Obtain from http://www.yelp.com/developer and " +
                   "set in your shell environment under 'YWSID'.")
    @yws_id = ENV['YWSID']
#    @client.debug = true
  end
  
  def create_v2_client
    
    assert_not_nil(ENV['YELP_CONSUMER_KEY'], "Missing consumer key.  Obtain from http://www.yelp.com/developer and " +
                   "set in your shell environment under 'YELP_CONSUMER_KEY'.")
    assert_not_nil(ENV['YELP_CONSUMER_SECRET'], "Missing consumer secret.  Obtain from http://www.yelp.com/developer and " +
                         "set in your shell environment under 'YELP_CONSUMER_SECRET'.")
    assert_not_nil(ENV['YELP_TOKEN'], "Missing OAuth token.  Obtain from http://www.yelp.com/developer and " +
                                              "set in your shell environment under 'YELP_TOKEN'.")
    assert_not_nil(ENV['YELP_TOKEN_SECRET'], "Missing OAuth token secret.  Obtain from http://www.yelp.com/developer and " +
                                        "set in your shell environment under 'YELP_TOKEN_SECRET'.")
                   
    @client = Yelp::V2::Client.new(
      :consumer_key => ENV['YELP_CONSUMER_KEY'],
      :consumer_secret => ENV['YELP_CONSUMER_SECRET'],
      :token => ENV['YELP_TOKEN'],
      :token_secret => ENV['YELP_TOKEN_SECRET']
    )
  end

  def validate_json_response (response)
    assert_not_nil response
    assert_instance_of String, response
    assert_match(/^\{"message": \{"text": "OK", "code": 0, "version": "1\.1\.1"\}, "(businesses|neighborhoods)": .*?\}$/, response)
  end

  def validate_json_to_ruby_response (response)
    assert_not_nil response
    assert_instance_of Hash, response
    assert_not_nil response['message']
    assert(response['message']['code'] == 0)
    assert(response['message']['text'] == 'OK')
    assert_not_nil((response['businesses'] || response['neighborhoods']))
    if response['businesses']
      response['businesses'].each { |b| validate_json_to_ruby_business(b) }
    end
  end

  YELP_BIZ_ID_LENGTH = 22

  def validate_json_to_ruby_business (business)
    # rudimentary checks to make sure it looks like a typical yelp business
    # result converted to a ruby hash
    assert business['id'].length == YELP_BIZ_ID_LENGTH
    assert_valid_url business['url']
  end

  # just a rudimentary check will serve us fine
  VALID_URL_REGEXP = /^https?:\/\/[a-z0-9]/i

  def assert_valid_url (url)
    assert_match VALID_URL_REGEXP, url
  end
end
