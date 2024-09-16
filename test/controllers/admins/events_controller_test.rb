require "test_helper"

class Admins::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_events_new_url
    assert_response :success
  end
end
