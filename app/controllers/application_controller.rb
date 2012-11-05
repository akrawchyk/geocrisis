class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :googGeoIP

  before_filter :load_persistent_location

  def load_persistent_location
    @session = Session.find_by_session_hash(session[:session_id])

    if @session.try(:location_id)
      @location = Location.find_by_id(@session.try(:location_id))
    end
  end


  def googGeoIP(query)
    require 'open-uri'

    return JSON.parse(open("#{Rails.application.config.goog_geocode_url}&address=#{query}&rankby=distance&sensor=false").read)['results']
  end

  def googleapi_by_latlng(latlng)
    require "net/http"
    require "uri"

    uri = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?latlng=#{latlng}&sensor=true")
    google_results = JSON.parse(Net::HTTP.get(uri))

    {:city => google_results['results'].first['address_components'].select { |component| component['types'].include?('locality') && component['types'].include?('political') }.first['long_name'],
     :county => google_results['results'].first['address_components'].select { |component| component['types'].include?('administrative_area_level_2') }.first['long_name'],
     :state => google_results['results'].first['address_components'].select { |component| component['types'].include?('administrative_area_level_1') }.first['short_name']}
  end
end