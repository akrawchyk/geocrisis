class LocationsController < ApplicationController
  def show
    if params[:id]
      @location = Location.find(params[:id])
    end

    if params[:latlng]
      @location = Location.first(:conditions => ['county_id = ?', County.find_by_latlng(params[:latlng]).id])
    end

    if params[:zipcode]
      @location = Location.find_by_zipcode(params[:zipcode])
    end

    if params[:city] && params[:state]
      @location = Location.find_by_city_and_state(params[:city], params[:state])
    end
  end
end