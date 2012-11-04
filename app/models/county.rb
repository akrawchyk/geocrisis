class County < ActiveRecord::Base
  attr_accessible :name, :fip
  has_and_belongs_to_many :locations
end
