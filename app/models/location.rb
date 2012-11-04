class Location < ActiveRecord::Base
  attr_accessible :city, :county_id, :state, :zipcode_id

  def self.find_by_zipcode(code)
    find(:first, :conditions => ['county_id = ?', Zipcode.find_by_code(code).county_id])
  end

  def self.find_by_county(county)
    find(:first, :conditions => ['county_id = ?', county.id])
  end

  belongs_to :county
end
