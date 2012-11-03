class Contact < ActiveRecord::Base
  attr_accessible :address, :city, :location_id, :name, :phone, :state, :type, :zip
end
