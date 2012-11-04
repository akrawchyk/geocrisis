class StaticPagesController < ApplicationController
  def home
    @hide_back_button = true
    @hide_menu = true
  end

  def landing_page
    @hide_nav = true
  end
end
