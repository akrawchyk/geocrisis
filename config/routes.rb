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

CrisisHelper::Application.routes.draw do
  root to: 'static_pages#landing_page'
  match '/home' => 'static_pages#home'

  get 'locations/:id' => 'locations#show', as: :location
  get 'locations' => 'locations#show', constraints: LocationByGeoipConstraint, as: :location_by_geoip
  get 'locations' => 'locations#show', constraints: LocationZipConstraint, as: :location_by_zip

  get "local_tweets" => "local_tweets#show"
end
