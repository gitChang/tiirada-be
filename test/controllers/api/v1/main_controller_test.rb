require "test_helper"

class Api::V1::MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_main_index_url
    assert_response :success
  end
end
