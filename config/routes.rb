class LocationByparams
  def self.matches?(request)
    return true if request.params[:latlng] =~ /-?\d+\.\d+,-?\d+\.\d+/

    return true if request.params[:zipcode] =~ /\d{5}/

    return true if request.params[:city] =~ /.+/ && request.params[:state] =~ /[A-Za-z]{2}/

    return false
  end
end

CrisisHelper::Application.routes.draw do

  root to: 'static_pages#landing_page'
  match '/home' => 'static_pages#home'
  match '/contacts' => 'static_pages#contact_list'
  match '/road_conditions' => 'road_conditions#show'
  match '/render_navigation' => 'common#render_navigation'

  match 'locations/:id' => 'locations#show', as: :location
  match 'locations' => 'locations#show', constraints: LocationByparams, as: :location_by_params

  get "local_tweets" => "local_tweets#show"

  get "shelters" => "shelters#show"

  get "noaa" => "noaa_alerts#show"
end
