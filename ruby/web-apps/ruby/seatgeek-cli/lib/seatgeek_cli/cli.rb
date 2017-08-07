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
    self.menu
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

  def prompt_user
    puts "What would you like to do?"
    puts " Either type 'list' to view the events again, or type the event number for more information"
  end

  def menu
    self.prompt_user
    input = gets.strip
    while input != 'exit'
      if input == 'list'
        self.list_events
      else
        # if an event is found, print it
        if event = SeatgeekCli::Event.all[input.to_i - 1]
          self.print_details(event)
        else
          puts "Can't find an event, try numbers between 1-#{SeatgeekCLI::Event.all.size}"
        end
      end
      self.prompt_user
      input = gets.strip
    end
    puts 'Goodbye!'
  end

  def print_details(event)
    puts "#{event.title}"
    puts "#{event.url}"
    puts "#{event.local_time_to_s}"
    puts "#{event.venue_name}"
    puts "#{event.venue_address}"
    puts "#{event.venue_city}"
    puts "#{event.venue_state}"
    puts "#{event.venue_url}"
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
