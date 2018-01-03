require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get documents_home_url
    assert_response :success
  end

end
