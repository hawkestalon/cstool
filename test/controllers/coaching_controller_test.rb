require 'test_helper'

class CoachingControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get coaching_new_url
    assert_response :success
  end

  test "should get edit" do
    get coaching_edit_url
    assert_response :success
  end

  test "should get show" do
    get coaching_show_url
    assert_response :success
  end

end
