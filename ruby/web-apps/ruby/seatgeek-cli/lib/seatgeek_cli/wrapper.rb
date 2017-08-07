class SeatgeekCli::Wrapper
  attr_reader :external_ip

  def initialize(ip)
    @external_ip = ip
  end

  def data
    my_clientid = 'ODQwNzg1NnwxNTAxOTQ1NjUwLjI0'
    url = "https://api.seatgeek.com/2/events?client_id=#{my_clientid}&geoip=#{self.external_ip}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    @data = response.body
  end

  def json
    @json ||= JSON.parse(self.data)
  end

  def events_data
    # return the value of the events property/key - array of event hashes
    self.json['events']
  end

  # def load_events
  #   # fetch event hashes, instatiate an event for each hash, setting it's properties
  #   self.events_data.collect do |event_hash|
  #     # return an array of event instances
  #     e = SeatgeekCli::Event.new
  #     e.title = event_hash['title']
  #     e.url = event_hash['url']
  #     e.local_time = DateTime.parse('event_hash[datetime_local]')
  #   end
  # end

  def user_location
    @user_location = self.json['meta']['geolocation']['display_name']
  end

end
