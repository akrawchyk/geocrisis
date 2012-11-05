class CommonController < ApplicationController
  def render_navigation
  	render :json => {
  		:html => render_to_string({
  			:partial => "navigation"
  		})
  	}
  end

  def utilities

  end

  def clear
    Session.find_by_session_hash(session[:session_id]).delete

    redirect_to '/'
  end
end
