module ApplicationHelper
  require 'open-uri'
  def googGeoIP(query)
    return JSON.parse(open("#{Rails.application.config.goog_geocode_url}&address=#{query}&rankby=distance&sensor=false").read)['results']
  end
end
