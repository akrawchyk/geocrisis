class Session < ActiveRecord::Base
  attr_accessible :latlng, :location_id, :session_hash
end
