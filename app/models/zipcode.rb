class Zipcode < ActiveRecord::Base
  attr_accessible :code
  belongs_to :county

  def self.find_by_code(code)
    find :first, :conditions => ['code = ?', code]
  end
end
