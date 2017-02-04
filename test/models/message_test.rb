require 'minitest/autorun'

class MessageTest < MiniTest::Test
  def setup
    @non_num = Message.new(posted_text: "where is my bus???")
    @invalid_num = Message.new(posted_text: "0")
  end

  def test_invalid_stop_id_response
    assert_equal "not found: stop ID where is my bus???", @non_num.text
    assert_equal "not found: stop ID 0", @invalid_num.text
  end

end
