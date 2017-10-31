require 'test_helper'

class AtoControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ato_new_url
    assert_response :success
  end

  test "should get edit" do
    get ato_edit_url
    assert_response :success
  end

  test "should get show" do
    get ato_show_url
    assert_response :success
  end

end
