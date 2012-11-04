class Location < ActiveRecord::Base
  attr_accessible :city, :county_id, :state, :zipcode_id
  belongs_to :county

  def get_cc
    "#{self.county.state_code}C#{self.county.fip}"
  end

  def self.find_by_zipcode(code)
    find(:first, :conditions => ['county_id = ?', Zipcode.find_by_code(code).county_id])
  end

  def self.find_by_county(county)
    find(:first, :conditions => ['county_id = ?', county.id])
  end

  has_and_belongs_to_many :counties
end
