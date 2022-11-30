require "test_helper"

class ChatBoxControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get chat_box_home_url
    assert_response :success
  end
end
