require 'test_helper'
class RoutingTest < ActiveSupport::TestCase
  test "location by id" do
    assert_generates "/location/1", {controller: "location", action: "show", id: "1"}
  end

  test 'location by geoip two negatives' do
    assert_generates "/location?latlng=-39.76144296429947,-104.8011589050293", {controller: "location", action: "show", latlng: "39.76144296429947,-104.8011589050293"}
  end

  test 'location by geoip one negative' do
    assert_generates "/location?latlng=39.76144296429947,-104.8011589050293", {controller: "location", action: "show", latlng: "39.76144296429947,-104.8011589050293"}
  end

  test 'location by geoip no negatives' do
    assert_generates "/location?latlng=-39.76144296429947,104.8011589050293", {controller: "location", action: "show", latlng: "39.76144296429947,-104.8011589050293"}
  end

  test 'location by zipcode' do
    assert_generates "/location?zipcode=21771", {controller: "location", action: "show", zipcode: "21771"}
  end
end