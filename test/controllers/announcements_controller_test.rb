require 'test_helper'

class AnnouncementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get announcements_new_url
    assert_response :success
  end

  test "should get edit" do
    get announcements_edit_url
    assert_response :success
  end

  test "should get delete" do
    get announcements_delete_url
    assert_response :success
  end

end
