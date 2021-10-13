require "test_helper"

class FollowControllerTest < ActionDispatch::IntegrationTest
  test "should get unfollow" do
    get follow_unfollow_url
    assert_response :success
  end
end
