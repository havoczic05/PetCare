require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest

  test "should get edit" do
    get pets_edit_url
    assert_response :success
  end

  test "should get update" do
    get pets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pets_destroy_url
    assert_response :success
  end

end
