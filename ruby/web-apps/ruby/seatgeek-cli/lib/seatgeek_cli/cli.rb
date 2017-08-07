require "seatgeek_cli/version"

class SeatgeekCli::CLI
  attr_reader :external_ip, :wrapper

  def initialize(ip = nil)
    @external_ip = ip || self.class.get_external_ip
    @wrapper = SeatgeekCli::Wrapper.new(self.external_ip)
    @wrapper.load_events
  end

  def call
    self.greet_user
    self.print_location
    self.list_events
  end

  def greet_user
    puts 'Welcome to seatgeek, the fan site where you can select from millions of tickets for purchase'
  end

  def print_location
    puts "Your location is: #{self.user_location}"
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

    # my_clientid = 'xxxx-xxxx-xxxxx-xxxx'
    # url = "https://api.seatgeek.com/2/events?client_id=#{my_clientid}&geoip=#{self.external_ip}"
    # uri = URI.parse(url)
    # response = Net::HTTP.get_response(uri)
    # data = response.body
    # json = JSON.parse(data)
    # @user_location = json['meta']['geolocation']['display_name']

    # @user_location = self.wrapper.user_location
    # puts "Your location is: #{@user_location}"
    self.wrapper.user_location
  end

  def list_events
    puts 'Events near you:'
    SeatgeekCli::Event.all.each.with_index(1) do |event, i|
      puts "#{i}. #{event.title}"
    end
  end
end
