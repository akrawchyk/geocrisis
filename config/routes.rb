CrisisHelper::Application.routes.draw do
  root to: 'static_pages#landing_page'
  match '/home' => 'static_pages#home'

  get 'locations/:id' => 'locations#show', as: :location
  get 'locations' => 'locations#show', contraints: {latlng: /-?\d+\.\d+,-?\d+\.\d+/}, as: :location_by_geoip
  get 'locations' => 'locations#show', contraints: {zipcode: /\d{5}/}, as: :location_by_zip
end
