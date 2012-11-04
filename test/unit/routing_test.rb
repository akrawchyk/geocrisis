require 'test_helper'
class LocationTest < ActiveSupport::TestCase
  test "location routes" do
    assert_generates "/location/1", {controller: "location", action: "show", id: "1"}
    #assert_generates "/location?latlng=-39.76144296429947,-104.8011589050293", {controller: "location", action: "show", latlng: "39.76144296429947,-104.8011589050293"}
    #assert_generates "/location?latlng=39.76144296429947,-104.8011589050293", {controller: "location", action: "show", latlng: "39.76144296429947,-104.8011589050293"}
    #assert_generates "/location?latlng=-39.76144296429947,104.8011589050293", {controller: "location", action: "show", latlng: "39.76144296429947,-104.8011589050293"}
    #assert_generates "/location?zipcode=21771", {controller: "location", action: "show", zipcode: "21771"}
  end
end