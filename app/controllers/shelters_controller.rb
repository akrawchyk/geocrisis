class SheltersController < ApplicationController
  require 'open-uri'
  require 'json'

  def show
    @show_back_button = true
    @nav_extra_klass = "downstream"
    @shelters = JSON.parse(open("#{Rails.application.config.goog_places_url}&keyword=American%20Red%20Cross&location=38.8657806,-77.1373328&rankby=distance&sensor=false").read)['results']
  end
end