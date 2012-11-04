class Location < ActiveRecord::Base
  attr_accessible :city, :county_id, :state, :zipcode_id

  def self.find_by_zipcode(code)
    zipcode = Zipcode.find_by_code(code)

    zipcode.location if zipcode
  end

  has_and_belongs_to_many :counties

  # get_lat_long_bounding_box
  # hacked out by ben brown <ben@xoxco.com>
  # http://xoxco.com/clickable/php-getboundingbox
  #
  # given a latitude and longitude in degrees (40.123123,-72.234234) and a distance in miles
  # calculates a bounding box with corners distance_in_miles away from the point specified.
  # returns min_lat,max_lat,min_lon,max_lon 	
  def self.get_lat_long_bounding_box(lat_degrees,lon_degrees,distance_in_miles=3000)	
	radius = 3963.1 # of earth in miles

	# bearings	
	due_north = 0
	due_south = 180
	due_east = 90
	due_west = 270

	# convert latitude and longitude into radians 
	lat_r = MathWiz.deg2rad(lat_degrees)
	lon_r = MathWiz.deg2rad(lon_degrees)
		
	# find the northmost, southmost, eastmost and westmost corners distance_in_miles away
	# original formula from
	# http://www.movable-type.co.uk/scripts/latlong.html

	northmost  = Math.sin(Math.sin(lat_r) * Math.cos(distance_in_miles/radius) + Math.cos(lat_r) * Math.sin(distance_in_miles/radius) * Math.cos(due_north))
	southmost  = Math.sin(Math.sin(lat_r) * Math.cos(distance_in_miles/radius) + Math.cos(lat_r) * Math.sin(distance_in_miles/radius) * Math.cos(due_south))
	
	eastmost = lon_r + Math.atan2(Math.sin(due_east)*Math.sin(distance_in_miles/radius)*Math.cos(lat_r),Math.cos(distance_in_miles/radius)-Math.sin(lat_r)*Math.sin(lat_r))
	westmost = lon_r + Math.atan2(Math.sin(due_west)*Math.sin(distance_in_miles/radius)*Math.cos(lat_r),Math.cos(distance_in_miles/radius)-Math.sin(lat_r)*Math.sin(lat_r))
		
	northmost = MathWiz.rad2deg(northmost)
	southmost = MathWiz.rad2deg(southmost)
	eastmost = MathWiz.rad2deg(eastmost)
	westmost = MathWiz.rad2deg(westmost)
		
	# sort the lat and long so that we can use them for a between query		
	if (northmost > southmost)
		lat1 = southmost
		lat2 = northmost
	else
		lat1 = northmost
		lat2 = southmost
	end

	if (eastmost > westmost)
		lon1 = westmost;
		lon2 = eastmost;
	else
		lon1 = eastmost;
		lon2 = westmost;
	end
	
	# api method expects it in this format
	return (lat1.to_s + "," + lon1.to_s + "," + lat2.to_s + "," + lon2.to_s)
  end  
end
