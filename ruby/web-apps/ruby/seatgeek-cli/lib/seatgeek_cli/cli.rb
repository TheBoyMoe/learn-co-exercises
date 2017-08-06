require "seatgeek_cli/version"

class SeatgeekCli::CLI
  attr_reader :external_ip

  def initialize(ip = nil)
    @external_ip = ip || self.class.get_external_ip
  end

  def call
    puts 'Welcome to seatgeek, the fan site where you can select from millions of tickets for purchase'
    puts 'Your location is: Wimbledon, GB'
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end

  def user_location
    # retrieve the user's location based on thier ip from seatgeek

    # json = {
    #   meta: {
    #     per_page: 10,
    #     total: 65,
    #     page: 1,
    #     geolocation: {
    #       city: 'Rockford',
    #       display_name: 'Rockford, IL',
    #       country: 'US',
    #       lon: -89.0816,
    #       lat: 42.3423
    #       .....
    #     }
    #   }
    # }

    my_clientid = 'ODQwNzg1NnwxNTAxOTQ1NjUwLjI0 '
    url = "https://api.seatgeek.com/2/events?client_id=#{my_clientid}&geoip=#{self.external_ip}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    data = response.body
    json = JSON.parse(data)
    @user_location = json['meta']['geolocation']['display_name']
    puts "Your location is: #{@user_location}"
  end

  def list_events
    puts 'Events near you:'
    SeatgeekCli::Event.all.each.with_index(1) do |event, i|
      puts "#{i}. #{event.title}"
    end
  end
end
