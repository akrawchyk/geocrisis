class Location < ActiveRecord::Base
  attr_accessible :city, :county_id, :state, :zipcode_id

  def self.find_by_zipcode(code)
    zipcode = Zipcode.find_by_code(code)

    zipcode.location if zipcode
  end
end
