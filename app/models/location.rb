class Location < ActiveRecord::Base
  attr_accessible :city, :county_id, :state, :zipcode_id
end
