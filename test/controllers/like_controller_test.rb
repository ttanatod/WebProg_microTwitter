require "test_helper"

class LikeControllerTest < ActionDispatch::IntegrationTest
  test "should get like" do
    get like_like_url
    assert_response :success
  end

  test "should get unlike" do
    get like_unlike_url
    assert_response :success
  end
end
