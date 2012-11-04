class StaticPagesController < ApplicationController
  def home
    @hide_back_button = true
    @hide_menu = true

    if session
      @sesh = session
      # @location = Location.find(session.location_id)
    end
  end

  def landing_page
    @hide_nav = true
  end
end
