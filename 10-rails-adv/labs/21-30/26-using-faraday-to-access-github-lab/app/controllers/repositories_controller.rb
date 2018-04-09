class RepositoriesController < ApplicationController

  # References
  # https://developer.github.com/v3/search/#search-repositories
  # https://developer.github.com/v3/#increasing-the-unauthenticated-rate-limit-for-oauth-applications

  # render ssearch view
  def search
  end

  # execute api request
  def github_search
    url = "https://api.github.com/search/repositories"
    begin
      @resp = Faraday.get(url) do |req|
        req.params['q'] = params[:query]
        req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
        req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
        # req.options.timeout = 0
      end
      puts @resp.success? # DEBUG
      if @resp.success?
        resp_body = JSON.parse(@resp.body)
        if resp_body['total_count'] > 0
          @items = resp_body['items']
        else
          @error = "No matches were found, try another search term"
        end
      else
        @error = "An error was encountered performing the request, try again."
      end
    rescue Faraday::ConnectionFailed
      @error = 'There was a time out, please try again.'
    end
    render :search
  end
end
