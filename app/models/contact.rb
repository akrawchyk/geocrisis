class Contact < ActiveRecord::Base
  attr_accessible :address, :county_id, :name, :phone, :type
end
