require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get application_index" do
    get articles_application_index_url
    assert_response :success
  end
end
