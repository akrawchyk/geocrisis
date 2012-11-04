class NoaaAlertsController < ApplicationController
  require 'open-uri'

  def show
    #TODO params should only be for json
    if (params[:cc].blank?)
      cc = @location.get_cc
    else
      cc = params[:cc]
    end

    # raise cc.inspect

    @feed = Nokogiri::XML(open("#{Rails.application.config.noaa_url}&x=#{cc}"))
    @feed.remove_namespaces!
    @noaa_alerts = @feed.xpath("//entry")

    @json = []
    @noaa_alerts.each do |alert|
      @json << {:title => alert.xpath("title").text, :summary => alert.xpath("summary").text}
    end

    respond_to do |format|
      format.html #TODO add auto location
      format.json { render :json => @json.to_json }
    end
  end
end
