Rails.application.config.goog_api_key = 'AIzaSyCuhvYtrzDnaaLF6YzI-GCrUcjO2wp0zTQ'
Rails.application.config.goog_geocode_url = "https://maps.googleapis.com/maps/api/geocode/json?"
Rails.application.config.goog_places_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{Rails.application.config.goog_api_key}"
