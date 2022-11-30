require "test_helper"

class TurboChatControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get turbochat_home_url
    assert_response :success
  end
end
