class StaticPagesController < ApplicationController
  def home

  end

  def landing_page
  	@hide_nav = true
  end
end
