class LocationsController < ApplicationController
  after_filter :handle_invalid_session, :only => :show

  def show
    if @session.try(:location_id)
      @location = @session.try(:location_id)
    else
      @location = Location.find(params[:id]) if params[:id]


      unless @location || params[:latlng].blank?
        google_data = googleapi_by_latlng(params[:latlng])
        @location = Location.find_by_city_and_state(google_data[:city], google_data[:state])
      end

      @location = Location.find_by_zipcode(params[:zipcode]) unless @location || params[:zipcode].blank?

      @location = Location.find_by_city_and_state(params[:city], params[:state]) unless @location || params[:city].blank? || params[:state].blank?
    end

    redirect_to '/'
  end

  def handle_invalid_session
    # Skip if we already have a saved location
    return if @session.try(:location_id)

    # Redirect if we didn't find a location
    redirect_to '/' and return unless @location

    # Create new session
    session = Session.new(:session_hash => request.session_options[:id])
    session.location_id = @location.id
    session.latlng = params[:latlng] unless params[:latlng].blank?

    session.save
  end
end
