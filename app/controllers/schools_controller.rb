class SchoolsController < ApplicationController
  def index
    redirect_to '/' and return unless @location

    @schools = Contact.find_all_by_contact_type_and_county_id('school', @location.county_id)
  end
end