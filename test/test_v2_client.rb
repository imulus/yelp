require 'test/unit'
require 'yelp'

class TestV2Client < Test::Unit::TestCase
  def test_validation
    # make sure we can do basic client instantiation
    assert_nothing_raised do
      @client = Yelp::V2::Client.new
    end
  end
end