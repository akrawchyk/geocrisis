class RoadConditionsController < ApplicationController
  require 'open-uri'
  require 'json'

  def show
    # TODO
    lat, lng = "34.0522", "-118.1373328"
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

      # puts "#{Rails.application.config.bing_maps_api_url.sub('#bounding_box', Location::get_lat_long_bounding_box(34.0522, 118.1373328) )}"
      # puts Location::get_lat_long_bounding_box(34.0522, 118.1373328, 20)
      # puts "#{Rails.application.config.bing_maps_api_url.sub('#bounding_box', bounding_box)}"
      @road_conditions = JSON.parse(open("#{Rails.application.config.bing_maps_api_url.sub('#bounding_box', bounding_box)}").read)
      # puts @road_conditions["resourceSets"][0]["resources"]
      @road_conditions = (@road_conditions != "") ? @road_conditions['resourceSets'][0]['resources'] : []

      unless @road_conditions.empty?
        break
      end
    end
  end
end
