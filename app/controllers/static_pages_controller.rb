class StaticPagesController < ApplicationController
  def home
    redirect_to '/' unless @session.try(:location_id) and (@location = Location.find_by_id(@session.try(:location_id)))

    @hide_back_button = true
    @hide_menu = true
  end

  def landing_page
    # Try to use session
    if @session.try(:location_id)
      @location = Location.find_by_id(@session.try(:location_id))

      render 'static_pages/home'
    end

    # No session, load view with form
    @hide_nav = true
  end

  def handle_invalid_session
    # Skip if we already have a saved location
    return if @session_location

    # Redirect if we didn't find a location
    redirect_to '/' unless @location

    # Create new session
    session = Session.new(:session_hash => request.session_options[:id])
    session.location_id = @location.id
    session.latlng = params[:latlng] unless params[:latlng].blank?
    session.save
  end
end
