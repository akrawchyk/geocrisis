class LocalTweetsController < ApplicationController
  def show
    # TODO
    @tweets = Twitter.search("#sandy", :geocode => '38.865805,-77.137318,2mi', :lang => 'en', :count => 30, :result_type => 'recent').results
  end
end
