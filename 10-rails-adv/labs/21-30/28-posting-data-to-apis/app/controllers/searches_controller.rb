class SearchesController < ApplicationController
  def search
  end
  def friends
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = session[:token]
      # don't forget that pesky v param for versioning
      req.params['v'] = '20160201'
    end
    @friends = JSON.parse(resp.body)["response"]["friends"]["items"]
  end

  def foursquare
    client_id = "CO3LIXJPH1LYAC5OOTLKLJE334NVDIYG24KUFOVEQ22WVYDP"
    client_secret = "0NNKMRWRYLCKLPSEE3G10I33WV0BTYXEN2JCJ41TVKKWB52Y"

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
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
end
