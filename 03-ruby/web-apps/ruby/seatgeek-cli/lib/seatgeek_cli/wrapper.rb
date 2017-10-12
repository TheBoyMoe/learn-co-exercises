class SeatgeekCli::Wrapper
  attr_reader :external_ip

  def initialize(ip)
    @external_ip = ip
  end

  def data
    unless @data
      my_clientid = 'xxx-xxxx-xxxx-xxxx'
      url = "https://api.seatgeek.com/2/events?client_id=#{my_clientid}&geoip=#{self.external_ip}"
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      @data = response.body
    else
      @data
    end
  end

  def json
    @json ||= JSON.parse(self.data)
  end

  def events_data
    # ret urn the value of the events property/key - array of event hashes
    self.json['events']
  end

  def load_events
    SeatgeekCli::Event.clear_all
    # fetch event hashes, instatiate an event for each hash, setting it's properties
    self.events_data.collect do |event_hash|
      # return an array of event instances
      e = SeatgeekCli::Event.new
      e.title = event_hash['title']
      e.url = event_hash['url']
      e.local_time = DateTime.parse(event_hash['datetime_local'])
      e.venue_name = event_hash['venue']['name']
      e.venue_address = event_hash['venue']['address']
      e.venue_city = event_hash['venue']['city']
      e.venue_state = event_hash['venue']['state']
      e.venue_url = event_hash['venue']['url']
      e.save # save the event to Event.all []
    end
  end

  def user_location
    @user_location = self.json['meta']['geolocation']['display_name']
  end

end
