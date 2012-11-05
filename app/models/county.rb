class County < ActiveRecord::Base
  attr_accessible :name, :fip
  has_and_belongs_to_many :locations
  has_many :zipcodes

  def self.find_by_latlng(latlng)


    find(:first, :conditions => ['name = ? and state_code = ?', name, state_code])
  end


end
