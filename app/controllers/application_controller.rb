class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_persistent_location

  def load_persistent_location
    @session_location = Session.find_by_session_hash(session[:session_id]).try(:location_id) if session[:session_id]
  end
end
