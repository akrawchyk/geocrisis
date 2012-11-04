class Zipcode < ActiveRecord::Base
  attr_accessible :code
  belongs_to :county

  def self.find_by_latlng(latlng)
    require "net/http"
    require "uri"

    uri = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?latlng=#{latlng}&sensor=true")
    google_results = JSON.parse(Net::HTTP.get(uri))

    google_results['results'].first['address_components'].select {|component| component['types'].first == 'postal_code'}.first['long_name']
  end

  def self.find_by_code(code)
    find :first, :conditions => ['code = ?', code]
  end
end
