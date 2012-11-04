require 'csv'
require 'nokogiri'
require 'open-uri'
require 'cgi'

class CountiesLocations < ActiveRecord::Base; end

namespace :locations do
  desc "populate db with the most populated cities in the US"
  task :populate_locations => :environment do
    locations = CSV.read("#{Rails.root}/lib/assets/cities.csv", encoding: "ISO8859-1")
    locations.each do |loc|
      Location.find_or_create_by_city_and_state(loc[0].strip, loc[1].strip)
    end
  end


  desc "connect cities to counties"
  task :countify => :environment do
    Location.all.each do |location|
      #begin
        city_url = "http://www.uscounties.org/cffiles_web/counties/city_res.cfm?city=#{CGI::escape location.city}"
        doc = Nokogiri::HTML(open city_url)
        doc.css("tr").each do |content|
          if content.at_css("td")
            #UPDATE Counties SET name=TRIM(TRAILING ' (city)' FROM name) WHERE name like '% (city)'
            state = content.at_css("td:first").text
            county = content.at_css("td:last a").text.gsub(/^[a-z]*-/i, '').gsub(/( City of )?( Borough)?( Parish)?( County)?(, City of Boston)?/, '')

            location.county = County.find_by_name(county) if state == location.state
          end
        end
        location.save
      #rescue
      #  puts location.inspect
      #end
    end
  end

  desc "Populates the counties_locations table from a csv file"
  task :populate_counties => :environment do
    counties_locations = CSV.read("#{Rails.root}/lib/assets/counties_locations.csv", encoding: "ISO8859-1")
    counties_locations.each do |cl|
      CountiesLocations.find_or_create_by_county_id_and_location_id(cl[0].strip, cl[1].strip)
    end
  end

  desc "Clears the data from the locations table"
  task :clear_locations => :environment do
    Location.delete_all
  end

  desc "Clears the data from the counties_locations table"
  task :clear_counties_locations => :environment do
    CountiesLocations.delete_all
  end

end
