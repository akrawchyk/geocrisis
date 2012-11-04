class RoadConditionsController < ApplicationController
  require 'open-uri'
  require 'json'

  def show
    redirect_to('/') and return unless @location 
    # TODO
    lat, lng = "38.9711", "-77.0767"
    places = JSON.parse(open("#{Rails.application.config.goog_geocode_url}latlng=#{lat},#{lng}&rankby=distance&sensor=false").read)['results']

    @road_conditions = []
    places.each do |place|
      if (place["geometry"]["viewport"])
        sw = place["geometry"]["viewport"]["southwest"]
        ne = place["geometry"]["viewport"]["northeast"]
      else
        sw = place["geometry"]["bounds"]["southwest"]
        ne = place["geometry"]["bounds"]["northeast"]
      end

      bounding_box = "#{sw['lat']},#{sw['lng']},#{ne['lat']},#{ne['lng']}"

      @road_conditions = JSON.parse(open("#{Rails.application.config.bing_maps_api_url.sub('#bounding_box', bounding_box)}").read)
      @road_conditions = (@road_conditions != "") ? @road_conditions['resourceSets'][0]['resources'] : []

      unless @road_conditions.empty?
        break
      end
    end
  end
end
