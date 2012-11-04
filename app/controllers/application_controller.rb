class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_persistent_location

  def load_persistent_location
    @session = Session.find_by_session_hash(session[:session_id])
  end
end