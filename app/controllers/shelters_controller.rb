class SheltersController < ApplicationController
  include ApplicationHelper
  require 'open-uri'
  require 'json'

  def show
    geo = googGeoIP(@location.county.zipcodes.first.code)
    pos = geo.first['geometry']['location']
    @shelters = JSON.parse(open("#{Rails.application.config.goog_places_url}&keyword=American%20Red%20Cross&location=#{pos['lat']},#{pos['lng']}&rankby=distance&sensor=false").read)['results']
  end
end
