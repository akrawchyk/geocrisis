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
end