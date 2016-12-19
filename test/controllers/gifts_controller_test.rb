require 'test_helper'

class GiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get gifts_new_url
    assert_response :success
  end

end
