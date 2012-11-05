class LocalTweetsController < ApplicationController
  include ApplicationHelper
  def show
    redirect_to '/' and return unless @location

    # TODO
    geo = googGeoIP(@location.county.zipcodes.first.code)
    pos = geo.first['geometry']['location']

    @tweets = Twitter.search("##{@location.city}", :geocode => "#{pos['lat']},#{pos['lng']},2mi", :lang => 'en', :count => 30, :result_type => 'recent', :max_id => (params[:id] ? params[:id] : '')).results
    # raise @tweets.inspect

    respond_to do |format|
      format.html
      format.json do
        render(:json => @tweets.to_json)
      end
    end
  end
end
