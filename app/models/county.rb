class County < ActiveRecord::Base
  attr_accessible :name, :fip
  has_and_belongs_to_many :locations
  has_many :zipcodes

  def self.find_by_latlng(latlng)
    require "net/http"
    require "uri"

    uri = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?latlng=#{latlng}&sensor=true")
    google_results = JSON.parse(Net::HTTP.get(uri))

    name = google_results['results'].first['address_components'].select {|component| component['types'].include?('administrative_area_level_2')}.first['long_name']
    state_code = google_results['results'].first['address_components'].select {|component| component['types'].include?('administrative_area_level_1')}.first['short_name']

    find(:first, :conditions => ['name = ? and state_code = ?', name, state_code])
  end


end
