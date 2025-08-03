require "test_helper"

class Api::V1::SignupControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_signup_create_url
    assert_response :success
  end
end
