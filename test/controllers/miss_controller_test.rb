require 'test_helper'

class MissControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get miss_new_url
    assert_response :success
  end

  test "should get create" do
    get miss_create_url
    assert_response :success
  end

  test "should get edit" do
    get miss_edit_url
    assert_response :success
  end

  test "should get update" do
    get miss_update_url
    assert_response :success
  end

  test "should get destroy" do
    get miss_destroy_url
    assert_response :success
  end

end
