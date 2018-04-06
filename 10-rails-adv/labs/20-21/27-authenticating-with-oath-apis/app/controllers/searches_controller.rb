class SearchesController < ApplicationController
  # skip_before_action :authenticate_user, only: [:friends]

  def search
  end

  def foursquare

    client_id = ENV['FOURSQUARE_CLIENT_ID']
    client_secret = ENV['FOURSQUARE_SECRET']

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.params['oauth_token'] = session[:token] # added so search works
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end

  def friends
    resp = Faraday.get('https://api.foursquare.com/v2/users/self/friends') do |req|
      # we need to pass in the user's oauth token with any request made
      req.params['oauth_token'] = session[:token] 
      req.params['v'] = '20160201'
    end
    @friends = JSON.parse(resp.body)['response']['friends']['items']
  end
end
