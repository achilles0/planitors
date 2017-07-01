require 'test_helper'

class UserPrefsControllerTest < ActionDispatch::IntegrationTest
  test "should get interests" do
    get user_prefs_interests_url
    assert_response :success
  end

end
