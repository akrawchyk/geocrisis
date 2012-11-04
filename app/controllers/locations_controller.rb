class LocationsController < ApplicationController
  def show
    if params[:id]
      Location.find(params[:id])
    end

    if params[:latlng]
      Location.find_by_zipcode(Zipcode.find_by_latlng(params[:latlng]))
    end

    if params[:zipcode]
      Location.find_by_zipcode(params[:zipcode])
    end

    if params[:city] and params[:state]
      Location.find_by_city_and_state(params[:city], params[:state])
    end
  end
end