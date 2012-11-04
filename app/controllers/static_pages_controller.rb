class StaticPagesController < ApplicationController
  def home

  end

  def landing_page
  	@hide_nav = true
  end

  def item_list
  	@nav_extra_klass = "downstream"
  	@show_back_button = true
  end
end
