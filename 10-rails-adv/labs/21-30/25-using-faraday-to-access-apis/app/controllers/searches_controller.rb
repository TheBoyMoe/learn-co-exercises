class SearchesController < ApplicationController

  # render the search form
  def search
  end

  # make api call passing in the req'd params via the block
  def foursquare
    begin
      @resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
        req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
        req.params['client_secret'] = ENV['FOURSQUARE_CLIENT_SECRET']
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0 # DEBUG
      end
      puts @resp.success? # DEBUG
      resp_body = JSON.parse(@resp.body)
      if @resp.success?
        # retrieve an array of venues
        @venues = resp_body['response']['venues']
      else
        @error = resp_body['meta']['errorDetail']
      end
    rescue Faraday::ConnectionFailed
      @error = 'There was a time out, please try again.'
    end
    render :search
  end
end
