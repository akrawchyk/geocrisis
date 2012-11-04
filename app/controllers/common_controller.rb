class CommonController < ApplicationController
  def render_navigation
  	render :json => {
  		:html => render_to_string({
  			:partial => "navigation"
  		})
  	}
  end
end
