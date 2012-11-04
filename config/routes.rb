class LocationByGeoipConstraint
  def self.matches?(request)
    request.params[:latlng] =~ /-?\d+\.\d+,-?\d+\.\d+/
    #/\d{5}/
  end
end
class LocationZipConstraint
  def self.matches?(request)
    request.params[:zipcode] =~ /\d{5}/
  end
end
class LocationCityConstraint
  def self.matches?(request)
    request.params[:city] =~ /.+/ and request.params[:state] =~ /[A-Za-z]{2}/
  end
end

CrisisHelper::Application.routes.draw do

  root to: 'static_pages#landing_page'
  match '/home' => 'static_pages#home'
  match '/contacts' => 'static_pages#contact_list'

  get 'locations/:id' => 'locations#show', as: :location
  get 'locations' => 'locations#show', constraints: LocationByGeoipConstraint, as: :location_by_geoip
  get 'locations' => 'locations#show', constraints: LocationZipConstraint, as: :location_by_zip
  get 'locations' => 'locations#show', constraints: LocationCityConstraint, as: :location_by_city

  get "local_tweets" => "local_tweets#show"

  get "shelters" => "shelters#show"
end
