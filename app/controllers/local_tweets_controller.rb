class LocalTweetsController < ApplicationController
  def show
    @tweets = Twitter.search("#sandy", :geocode => '38.865805,-77.137318,2mi', :lang => 'en', :count => 30, :result_type => 'recent').results
    @nav_extra_klass = "downstream"
    @show_back_button = true
  end
end
