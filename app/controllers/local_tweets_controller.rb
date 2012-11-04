class LocalTweetsController < ApplicationController
  def show
    # TODO
    @tweets = Twitter.search("#sandy", :geocode => '38.865805,-77.137318,2mi', :lang => 'en', :count => 30, :result_type => 'recent', :max_id => (params[:id] ? params[:id] : '')).results

    respond_to do |format|
      format.html
      format.json do
        render(:json => @tweets.to_json)
      end
    end
  end
end
