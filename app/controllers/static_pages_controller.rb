class StaticPagesController < ApplicationController
  def home
    @hide_back_button = true
    @hide_menu = true
  end

  def landing_page
    render :home and return if @session_location and @location = Location.find_by_id(@session_location)

    @hide_nav = true
  end

  def handle_invalid_session
    # Skip if we already have a saved location
    return if @session_location

    # Redirect if we didn't find a location
    redirect_to '/home' unless @location

    # Create new session
    session = Session.new(:session_hash => request.session_options[:id])
    session.location_id = @location.id
    session.latlng = params[:latlng] unless params[:latlng].blank?
    session.save
  end
end
