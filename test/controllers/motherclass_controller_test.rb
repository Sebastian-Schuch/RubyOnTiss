require "test_helper"

class MotherclassControllerTest < ActionDispatch::IntegrationTest
  test "should get application_motherclass" do
    get motherclass_application_motherclass_url
    assert_response :success
  end
end
