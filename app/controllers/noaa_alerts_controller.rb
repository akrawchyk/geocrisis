class NoaaAlertsController < ApplicationController
  require 'open-uri'

  def show
    @feed = Nokogiri::XML(open("#{Rails.application.config.noaa_url}&x=#{params[:cc]}"))
    @feed.remove_namespaces!
    @noaa_alerts = @feed.xpath("//entry")

    @json = []
    @noaa_alerts.each do |alert|
      @json << {:title => alert.xpath("title").text, :summary => alert.xpath("summary").text}
    end

    respond_to do |format|
      format.html
      format.json { render :json => @json.to_json }
    end
  end
end
