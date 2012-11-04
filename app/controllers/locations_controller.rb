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
  end
end